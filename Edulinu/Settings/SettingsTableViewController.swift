//
//  SettingsTableViewController.swift
//  Edulinu
//
//  Created by Laurens on 10.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // Section: My Edulinu
    
    @IBOutlet weak var myEdShowTeacherShortSwitch: UISwitch!
    
    @IBAction func myEdShowTeacherShortSwitchToggled(_ sender: Any) {
        
        if myEdShowTeacherShortSwitch.isOn {
            edulinuLocalUserSettings.set(true, forKey: Keys.ElusSettingsMyEdShowTeacherShort)
        }
        else {
            edulinuLocalUserSettings.set(false, forKey: Keys.ElusSettingsMyEdShowTeacherShort)
        }
        
    }
    
    // Section: Lehrer
    
    @IBOutlet weak var teacherShowTeacherShortSwitch: UISwitch!
    
    @IBAction func teacherShowTeacherShortSwitchToggled(_ sender: Any) {
        
        if teacherShowTeacherShortSwitch.isOn {
            edulinuLocalUserSettings.set(true, forKey: Keys.ElusSettingsTeacherTableShowTeacherShort)
        }
        else {
            edulinuLocalUserSettings.set(false, forKey: Keys.ElusSettingsTeacherTableShowTeacherShort)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Einstellungen"
        
        // Section: My Edulinu
        
        if edulinuLocalUserSettings.bool(forKey: Keys.ElusSettingsMyEdShowTeacherShort) {
            self.myEdShowTeacherShortSwitch.isOn = true
        } else {
            self.myEdShowTeacherShortSwitch.isOn = false
        }
        
        // Section: Lehrer
        
        if edulinuLocalUserSettings.bool(forKey: Keys.ElusSettingsTeacherTableShowTeacherShort) {
            self.teacherShowTeacherShortSwitch.isOn = true
        } else {
            self.teacherShowTeacherShortSwitch.isOn = false
        }
        
        
    }

}
