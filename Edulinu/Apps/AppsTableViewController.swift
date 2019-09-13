//
//  AppsTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 23.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class AppsTableViewController: UITableViewController {
    
    // MARK: Properties
    var apps: [App] = []
    let ref = Database.database().reference(withPath: "apps")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.rowHeight = 75
        
        ref.queryOrdered(byChild: "id").observe(.value, with: { snapshot in
            var newApps: [App] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let app = App(snapshot: snapshot) {
                    newApps.append(app)
                }
                
            }
            
            self.apps = newApps
            
            self.tableView.reloadData()
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: UITableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(apps.count)
        return apps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath)
        
        let app = apps[indexPath.row]

        cell.textLabel?.text = app.title
        cell.detailTextLabel?.text = app.desc

        cell.imageView?.sd_setImage(with: URL(string: app.imageURL), placeholderImage: UIImage(named: "loading512x512_white"), options: [])
        //cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let app = apps[indexPath.row]
        
        UIApplication.shared.open(URL(string: app.appStoreLink)! as URL, options: [:], completionHandler: nil)
    }
    
}
