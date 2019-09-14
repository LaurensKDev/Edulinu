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
    static let ElusDidSplash = "ElusDidSplash"
    static let ElusFirstName = "ElusFirstName"
    static let ElusLastName = "ElusLastName"
    static let ElusUserRole = "ElusUserRole" // "student" or "parent"
    static let ElusClass = "ElusClass"
    static let ElusHasAgreedToSentStatistics = "ElusHasAgreedToSentStatistics"
}

//edulinuLocalUserSettings.bool(forKey: Keys.ElusDidSplash)
