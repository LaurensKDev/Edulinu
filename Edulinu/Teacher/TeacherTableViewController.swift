//
//  TeacherTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 23.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import SafariServices
import Firebase
import SDWebImage

class TeacherTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    
    // MARK: Properties
    var teachers: [Teacher] = []
    
    var filteredTeachers = [Teacher]()
    let searchController = UISearchController(searchResultsController: nil)
    
    let ref = Database.database().reference(withPath: "teachers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.rowHeight = 80
        
        ref.queryOrdered(byChild: "teacherShort").observe(.value, with: { snapshot in
            var newTeachers: [Teacher] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let teacher = Teacher(snapshot: snapshot) {
                    newTeachers.append(teacher)
                }
                
            }
            
            self.teachers = newTeachers
            
            self.tableView.reloadData()
        })
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Lehrer suchen"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: UITableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
          return filteredTeachers.count
        }
          
        return teachers.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherCell", for: indexPath)
        
        let teacher: Teacher
        
        if isFiltering() {
            teacher = filteredTeachers[indexPath.row]
        } else {
            teacher = teachers[indexPath.row]
        }
        
        cell.textLabel?.text = "\(teacher.firstName) \(teacher.lastName)"
        
        if edulinuLocalUserSettings.bool(forKey: Keys.ElusSettingsTeacherTableShowTeacherShort) {
            
            if teacher.desc.isEmpty {
                cell.detailTextLabel?.text = "\(teacher.teacherShort.uppercased())"
            } else {
                cell.detailTextLabel?.text = "\(teacher.teacherShort.uppercased()) - \(teacher.desc)"
            }
            
        } else {
            
            cell.detailTextLabel?.text = "\(teacher.desc)"
            
        }
        
        
        
        cell.imageView?.sd_setImage(with: URL(string: teacher.imageURL), placeholderImage: UIImage(named: "loading214x322_white"), options: [])
        //cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        
        let teacher: Teacher
        
        if isFiltering() {
            teacher = filteredTeachers[indexPath.row]
        } else {
            teacher = teachers[indexPath.row]
        }
        
        showPortal(teacher.hasPortal, teacher.portalURL, teacher.firstName, teacher.lastName, teacher.gender)
    }
    
    func showPortal (_ hasPortal: Bool, _ portalURL: String, _ firstName: String, _ lastName: String, _ gender: String) {
        
        var genderInText: String
        
        if gender == "w" {
            genderInText = "Frau"
        } else if gender == "m" {
            genderInText = "Herr"
        } else {
            genderInText = firstName
        }
        
        if hasPortal == false {
            
            let alert = UIAlertController(title: "Kein Portal", message: "\(genderInText) \(lastName) hat kein Portal.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if hasPortal == true {
            
            if let url = URL(string: portalURL) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                
                present(vc, animated: true)
            }
            
        } else {
            
            let alert = UIAlertController(title: "Fehler", message: "Ein unbekannter Fehler ist aufgetreten!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        }
    }
    
    // MARK: - Private instance methods
      
    func searchBarIsEmpty() -> Bool {
      // Returns true if the text is empty or nil
      return searchController.searchBar.text?.isEmpty ?? true
    }
      
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
      filteredTeachers = teachers.filter({( teacher : Teacher) -> Bool in
        let teachername = "\(teacher.firstName) \(teacher.lastName)"
        return teachername.lowercased().contains(searchText.lowercased())
      })

      tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }
    
}
