//
//  ExtElusResetUserDefaults.swift
//  Edulinu
//
//  Created by Laurens on 11.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func elusResetUserDefaults() {
        
        // General
        edulinuLocalUserSettings.set(false, forKey: Keys.ElusDidSplash)
        edulinuLocalUserSettings.set("noFirstName", forKey: Keys.ElusFirstName)
        edulinuLocalUserSettings.set("noLastName", forKey: Keys.ElusLastName)
        edulinuLocalUserSettings.set("noClass", forKey: Keys.ElusClass)
        edulinuLocalUserSettings.set(true, forKey: Keys.ElusHasAgreedToSentStatistics)
        edulinuLocalUserSettings.set([""], forKey: Keys.ElusFavouriteTeachers)
        
        // Settings
        
        // Section: My Edulinu
        edulinuLocalUserSettings.set(false, forKey: Keys.ElusSettingsMyEdShowTeacherShort)
        
        // Section: Lehrer
        edulinuLocalUserSettings.set(false, forKey: Keys.ElusSettingsTeacherTableShowTeacherShort)

    }
    
}

