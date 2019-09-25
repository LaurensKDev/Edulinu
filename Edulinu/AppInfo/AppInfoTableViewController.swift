//
//  AppInfoTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 12.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase

class AppInfoTableViewController: UITableViewController {
    
    var appInfoDatabaseVersion: String = ""
    var appInfoDatabaseRoot: String = ""
    var appInfoDeveloper: String = ""
    var appInfoDevelopmentTimeHours: Int = 0
    var appInfoDevelopmentTimeMinutes: Int = 0
    
    let ref = Database.database().reference(withPath: "appInfo")

    @IBOutlet weak var appVersionLabel: UILabel!
    
    @IBOutlet weak var appBuildLabel: UILabel!
    
    @IBOutlet weak var databaseVersionLabel: UILabel!
    
    @IBOutlet weak var databaseRootLabel: UILabel!
    
    @IBOutlet weak var developerLabel: UILabel!
    
    @IBOutlet weak var developmentTimeLabel: UILabel!
    
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
                
                self.appVersionLabel.text? = appVersion ?? ""
                self.appBuildLabel.text? = build ?? ""
                self.databaseVersionLabel.text? = self.appInfoDatabaseVersion
                self.databaseRootLabel.text? = self.appInfoDatabaseRoot
                self.developerLabel.text? = self.appInfoDeveloper
                self.developmentTimeLabel.text? = "\(self.appInfoDevelopmentTimeHours) h \(self.appInfoDevelopmentTimeMinutes) min"
                
                
                
            }
        })
    }
}
