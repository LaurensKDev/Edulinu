//
//  AppInfoTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 12.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase

struct AppInfo {
    
    var id : Int
    var title : String
    var text : String
    
}


class AppInfoTableViewController: UITableViewController {
    
    var appInfoDatabaseVersion: String = ""
    var appInfoDatabaseRoot: String = ""
    var appInfoDeveloper: String = ""
    var appInfoDevelopmentTimeHours: Int = 0
    var appInfoDevelopmentTimeMinutes: Int = 0
    
    var appInfoRows: [AppInfo] = []
    
    let ref = Database.database().reference(withPath: "appInfo")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "App-Infos"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        ref.observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                self.appInfoDatabaseVersion = value["appInfoDatabaseVersion"] as? String ?? ""
                self.appInfoDatabaseRoot = value["appInfoDatabaseRoot"] as? String ?? ""
                self.appInfoDeveloper = value["appInfoDeveloper"] as? String ?? ""
                self.appInfoDevelopmentTimeHours = value["appInfoDevelopmentTimeHours"] as? Int ?? 0
                self.appInfoDevelopmentTimeMinutes = value["appInfoDevelopmentTimeMinutes"] as? Int ?? 0
                
                self.appInfoRows = []
                
                self.appInfoRows.append(AppInfo(id: 0, title: "App-Version", text: appVersion!))
                self.appInfoRows.append(AppInfo(id: 1, title: "App-Build", text: build!))
                self.appInfoRows.append(AppInfo(id: 1, title: "Datenbank-Version", text: self.appInfoDatabaseVersion))
                self.appInfoRows.append(AppInfo(id: 1, title: "Datenbank-Root", text: self.appInfoDatabaseRoot))
                self.appInfoRows.append(AppInfo(id: 1, title: "Entwickler", text: self.appInfoDeveloper))
                self.appInfoRows.append(AppInfo(id: 1, title: "Entwicklungszeit", text: "\(self.appInfoDevelopmentTimeHours) h \(self.appInfoDevelopmentTimeMinutes) min"))
                
                self.tableView.reloadData()
                
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appInfoRows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppInfoCell", for: indexPath)
        
        let appInfoRow = appInfoRows[indexPath.row]
        
        cell.textLabel?.text = appInfoRow.title
        cell.detailTextLabel?.text = appInfoRow.text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
