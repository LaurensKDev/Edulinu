//
//  AppInfoTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 12.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

struct AppInfo {
    
    var id : Int
    var title : String
    var text : String
    
}


class AppInfoTableViewController: UITableViewController {
    
    
    
    var appInfoRows: [AppInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "App-Infos"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        appInfoRows.append(AppInfo(id: 0, title: "App-Version", text: appVersion!))
        appInfoRows.append(AppInfo(id: 1, title: "Build-Nummer", text: build!))
        appInfoRows.append(AppInfo(id: 1, title: "Entwickler", text: "Laurens K."))
        
        tableView.reloadData()
        
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
