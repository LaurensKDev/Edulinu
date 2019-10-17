//
//  LocalUserSettingsSetup.swift
//  Edulinu
//
//  Created by Laurens on 06.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation

let edulinuLocalUserSettings = UserDefaults.standard

struct Keys {
    
    // General
    static let ElusDidSplash = "ElusDidSplash"
    static let ElusFirstName = "ElusFirstName"
    static let ElusLastName = "ElusLastName"
    static let ElusUserRole = "ElusUserRole" // "student", "parent" or "teacher"
    static let ElusClass = "ElusClass"
    static let ElusLastUpdateDate = "ElusLastUpdateDate"
    static let ElusHasAgreedToSentStatistics = "ElusHasAgreedToSentStatistics"
    static let ElusFavouriteTeachers = "ElusFavouriteTeachers"
    
    // Settings
    
    // Section: My Edulinu
    static let ElusSettingsMyEdShowTeacherShort = "ElusSettingsMyEdShowTeacherShort"
    
    // Section: Lehrer
    static let ElusSettingsTeacherTableShowTeacherShort = "ElusSettingsTeacherTableShowTeacherShort"
}

//edulinuLocalUserSettings.bool(forKey: Keys.ElusDidSplash)
