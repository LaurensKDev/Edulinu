//
//  MoreEntry.swift
//  Edulinu
//
//  Created by Laurens on 24.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

//not working at all

import Foundation
import Firebase

struct MoreSection {
    
    let ref: DatabaseReference?
    let key: String
    let entries: Dictionary<String, AnyObject>
    let id: Int
    let name: String
    
    init(entries: Dictionary<String, AnyObject>, id: Int, name: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.entries = entries
        self.id = id
        self.name = name
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let entries = value["entries"] as? Dictionary<String, AnyObject>,
            let id = value["id"] as? Int,
            let name = value["name"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.entries = entries
        self.id = id
        self.name = name
        
    }
    
    func toAnyObject() -> Any {
        return [
            "entries": entries,
            "id": id,
            "name": name
        ]
    }
}
