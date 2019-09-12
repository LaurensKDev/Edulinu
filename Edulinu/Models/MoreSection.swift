//
//  MoreEntry.swift
//  Edulinu
//
//  Created by Laurens on 24.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import Firebase

struct MoreSection {
    
    let ref: DatabaseReference?
    let key: String
    let id: Int
    let name: String
    let identifier: String
    
    init(id: Int, name: String, identifier: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.id = id
        self.name = name
        self.identifier = identifier
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value["id"] as? Int,
            let name = value["name"] as? String,
            let identifier = value["identifier"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.id = id
        self.name = name
        self.identifier = identifier
        
    }
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "name": name,
            "identifier": identifier
        ]
    }
}
