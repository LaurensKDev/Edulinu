//
//  TeacherSettingsTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 10.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class TeacherSettingsTableViewController: UITableViewController {
    
    @IBAction func doneButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var showTeacherShortSwitch: UISwitch!
    
    @IBAction func shoeTeacherShortSwitchToggled(_ sender: Any) {
        
        if showTeacherShortSwitch.isOn {
            edulinuLocalUserSettings.set(true, forKey: Keys.ElusTeacherTableShowTeacherShort)
        }
        else {
            edulinuLocalUserSettings.set(false, forKey: Keys.ElusTeacherTableShowTeacherShort)
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "teacherTableSettingsUpdated"), object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Einstellungen"
        
        if edulinuLocalUserSettings.bool(forKey: Keys.ElusTeacherTableShowTeacherShort) {
            self.showTeacherShortSwitch.isOn = true
        } else {
            self.showTeacherShortSwitch.isOn = false
        }
        
        
    }

}
