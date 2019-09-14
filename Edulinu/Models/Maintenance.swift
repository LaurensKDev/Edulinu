//
//  Maintenance.swift
//  Edulinu
//
//  Created by Laurens on 14.09.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import Firebase

struct Maintenance {
    
    let ref: DatabaseReference?
    let key: String
    let maintenanceMessage: String
    let maintenanceMode: Bool
    let maintenanceTitle: String
    
    init(maintenanceMessage: String, maintenanceMode: Bool, maintenanceTitle: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.maintenanceMessage = maintenanceMessage
        self.maintenanceMode = maintenanceMode
        self.maintenanceTitle = maintenanceTitle
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let maintenanceMessage = value["maintenanceMessage"] as? String,
            let maintenanceMode = value["maintenanceMode"] as? Bool,
            let maintenanceTitle = value["maintenanceTitle"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.maintenanceMessage = maintenanceMessage
        self.maintenanceMode = maintenanceMode
        self.maintenanceTitle = maintenanceTitle
    }
    
    func toAnyObject() -> Any {
        return [
            "maintenanceMessage": maintenanceMessage,
            "maintenanceMode": maintenanceMode,
            "maintenanceTitle": maintenanceTitle
        ]
    }
}
