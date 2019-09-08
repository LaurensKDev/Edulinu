//
//  MoreSectionEntry.swift
//  Edulinu
//
//  Created by Laurens on 24.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import Firebase

struct MoreSectionEntry {
    
    let ref: DatabaseReference?
    let key: String
    let URL: String
    let desc: String
    let id: Int
    let onClickAction: String
    let title: String
    
    init(URL: String, desc: String, id: Int, onClickAction: String, title: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.URL = URL
        self.desc = desc
        self.id = id
        self.onClickAction = onClickAction
        self.title = title
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let URL = value["URL"] as? String,
            let desc = value["desc"] as? String,
            let id = value["id"] as? Int,
            let onClickAction = value["onClickAction"] as? String,
            let title = value["title"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.URL = URL
        self.desc = desc
        self.id = id
        self.onClickAction = onClickAction
        self.title = title
        
    }
    
    func toAnyObject() -> Any {
        return [
            "URL": URL,
            "desc": desc,
            "id": id,
            "onClickAction": onClickAction,
            "title": title
        ]
    }
}
