//
//  App.swift
//  Edulinu
//
//  Created by Laurens on 23.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import Firebase

struct App {
    
    let ref: DatabaseReference?
    let key: String
    let appScheme: String
    let appStoreLink: String
    let desc: String
    let id: Int
    let imageURL: String
    let title: String
    
    init(appScheme: String, appStoreLink: String, desc: String, id: Int, imageURL: String, title: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.appScheme = appScheme
        self.appStoreLink = appStoreLink
        self.desc = desc
        self.id = id
        self.imageURL = imageURL
        self.title = title
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let appScheme = value["appScheme"] as? String,
            let appStoreLink = value["appStoreLink"] as? String,
            let desc = value["desc"] as? String,
            let id = value["id"] as? Int,
            let imageURL = value["imageURL"] as? String,
            let title = value["title"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.appScheme = appScheme
        self.appStoreLink = appStoreLink
        self.desc = desc
        self.id = id
        self.imageURL = imageURL
        self.title = title
    }
    
    func toAnyObject() -> Any {
        return [
            "appScheme": appScheme,
            "appStoreLink": appStoreLink,
            "desc": desc,
            "id": id,
            "imageURL": imageURL,
            "title": title
        ]
    }
}
