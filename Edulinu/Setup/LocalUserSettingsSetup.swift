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
    static let wasOnSplashscreen = "wasOnSplashscreen"
    static let name = "name"
    static let isStudent = "isStudent"
    static let hasAgreedMailMessage = "hasAgreedMailMessage"
}
