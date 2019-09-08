//
//  MoreTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 24.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase

class MoreTableViewController: UITableViewController {
    
    
    
    // MARK: Properties
    var moreSections: [MoreSection] = []
    let ref = Database.database().reference(withPath: "moreSections")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        ref.queryOrdered(byChild: "id").observe(.value, with: { snapshot in
            var newMoreSections: [MoreSection] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let moreSection = MoreSection(snapshot: snapshot) {
                    newMoreSections.append(moreSection)
                }
                
            }
            
            self.moreSections = newMoreSections
            
            
            
//            print(self.moreSections)
//            print(type(of: self.moreSections))
            
            self.tableView.reloadData()
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return moreSections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moreSections[section].name
    }

    // MARK: UITableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (moreSections[section].entries as AnyObject).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        
        //print(moreSections[indexPath.section].entries[indexPath.row])
        
        //let entry = moreSections[indexPath.section].entries["bugReport"]
        
//        let test = moreSections[indexPath.section].entries[indexPath.row]
//        let entry = Array(moreSections[indexPath.section].entries)[indexPath.row].value
//        print(entry)
//
//        cell.textLabel?.text = entry.title
//        cell.detailTextLabel?.text = entry.desc


        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let cell = tableView.cellForRow(at: indexPath) else { return }
//        tableView.deselectRow(at: indexPath, animated: true)
//        let app = apps[indexPath.row]
//
//        UIApplication.shared.open(URL(string: app.appStoreLink)! as URL, options: [:], completionHandler: nil)
    }

}

