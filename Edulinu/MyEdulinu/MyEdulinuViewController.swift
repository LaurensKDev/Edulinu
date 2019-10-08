
//
//  MyEdulinuViewController.swift
//  Edulinu
//
//  Created by Laurens Kropf on 04.03.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import SafariServices
import Firebase
import SDWebImage

var teacherArray = ["bae", "wab"]

class MyEdulinuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
    var teachers: [Teacher] = []
    
    @IBOutlet weak var dayTimeLabel: UILabel!
    
    @IBOutlet weak var dayTimeImage: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
  
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myEdTeacherNavigationBar: UINavigationBar!
    
    @IBOutlet weak var myEdTeacherTableView: UITableView!
    
    @IBAction func myEdTeacherAddTeacherButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "AddFavouriteTeacher", bundle: nil)
        let myEdAddFavouriteTeacherTableViewController = storyboard.instantiateViewController(withIdentifier: "MyEdAddFavouriteTeacherTableViewController") as! UINavigationController
        myEdAddFavouriteTeacherTableViewController.modalPresentationStyle = .fullScreen
        self.present(myEdAddFavouriteTeacherTableViewController, animated: true, completion: nil)
        
    }
    
    var timer: Timer?
    
    // MARK: Properties
    var myEdTeachers: [Teacher] = []
    let ref = Database.database().reference(withPath: "teachers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayTimeSetup()
        
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.dayTimeSetup), userInfo: nil, repeats: true)
        
        if edulinuLocalUserSettings.string(forKey: Keys.ElusUserRole) == "student" {
            myEdTeacherNavigationBar.topItem?.title = "Deine Lehrer"
        } else {
            myEdTeacherNavigationBar.topItem?.title = "Favorisierte Lehrer"
        }
        
        
        myEdTeacherTableView.dataSource = self
        myEdTeacherTableView.delegate = self
        myEdTeacherTableView.rowHeight = 80
        
        ref.queryOrdered(byChild: "teacherShort").observe(.value, with: { snapshot in
            var newMyEdTeachers: [Teacher] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let myEdTeacher = Teacher(snapshot: snapshot) {
                    newMyEdTeachers.append(myEdTeacher)
                }
                
            }
            
            self.myEdTeachers = newMyEdTeachers
            
            self.teachers = self.matchTeachers(self.myEdTeachers, edulinuLocalUserSettings.array(forKey: Keys.ElusFavouriteTeachers) as! Array<String>)
            
            self.myEdTeacherTableView.reloadData()
            
        })
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.teachers = self.matchTeachers(self.myEdTeachers, edulinuLocalUserSettings.array(forKey: Keys.ElusFavouriteTeachers) as! Array<String>)
        
        self.myEdTeacherTableView.reloadData()
        
    }
    
    func reloadTeacherTableView() {
        self.teachers = self.matchTeachers(self.myEdTeachers, edulinuLocalUserSettings.array(forKey: Keys.ElusFavouriteTeachers) as! Array<String>)
        
        self.myEdTeacherTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: UITableView Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(apps.count)
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEdTeacherCell", for: indexPath)
        
        let teacher = teachers[indexPath.row]
        
        cell.textLabel?.text = "\(teacher.firstName) \(teacher.lastName)"
        cell.detailTextLabel?.text = teacher.desc
        
        cell.imageView?.sd_setImage(with: URL(string: teacher.imageURL), placeholderImage: UIImage(named: "loading214x322_white"), options: [])
        //cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let teacher = teachers[indexPath.row]
        
        showPortal(teacher.hasPortal, teacher.portalURL, teacher.firstName, teacher.lastName, teacher.gender)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            var localFavouriteTeachers = edulinuLocalUserSettings.array(forKey: Keys.ElusFavouriteTeachers) as! Array<String>
            
            localFavouriteTeachers.remove(at: indexPath.row)
            
            teachers.remove(at: indexPath.row)
            
            edulinuLocalUserSettings.set(localFavouriteTeachers, forKey: Keys.ElusFavouriteTeachers)
            
            myEdTeacherTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        timer?.invalidate()
        
    }
    
    
    @objc func dayTimeSetup() {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "EEEE, d. MMMM yyyy"
        let formattedDate = format.string(from: date)
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if edulinuLocalUserSettings.string(forKey: Keys.ElusUserRole) == "student" {
            firstNameLabel.text = edulinuLocalUserSettings.string(forKey: Keys.ElusFirstName)
        } else {
            firstNameLabel.text = "\(edulinuLocalUserSettings.string(forKey: Keys.ElusFirstName) ?? "Edulinu") \(edulinuLocalUserSettings.string(forKey: Keys.ElusLastName) ?? "User")"
        }
        
        dateLabel.text = formattedDate
        
        if hour >= 6 && hour <= 9 {
            dayTimeLabel.text = "Guten Morgen,"
            dayTimeImage.image = UIImage(named: "sunrise")
        } else if hour >= 10 && hour <= 17 {
            dayTimeLabel.text = "Schönen Tag,"
            dayTimeImage.image = UIImage(named: "sun")
        } else if hour >= 18 && hour <= 20 {
            dayTimeLabel.text = "Guten Abend,"
            dayTimeImage.image = UIImage(named: "sunset")
        } else if hour >= 21 && hour <= 24 {
            dayTimeLabel.text = "Gute Nacht,"
            dayTimeImage.image = UIImage(named: "moon")
        } else if hour >= 0 && hour <= 5 {
            dayTimeLabel.text = "Gute Nacht,"
            dayTimeImage.image = UIImage(named: "moon")
        } else {
            dayTimeLabel.text = "Willkommen,"
            dayTimeImage.image = UIImage(named: "sun")
        }
        
    }
    
    func matchTeachers(_ teachers: [Teacher], _ teacherArray: Array<String>) -> [Teacher] {
        
        var matchedTeachers: [Teacher] = []
        
        for entry in teacherArray {
            
            for teacher in teachers {
                
                if teacher.teacherShort == entry {
                    
                    matchedTeachers.append(teacher)
                    
                }
                
            }
            
        }
        
        return matchedTeachers
        
    }
}
