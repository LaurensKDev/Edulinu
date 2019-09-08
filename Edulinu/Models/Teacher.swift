//
//  Teacher.swift
//  Edulinu
//
//  Created by Laurens on 23.08.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import Firebase

struct Teacher {
    
    let ref: DatabaseReference?
    let key: String
    let desc: String
    let firstName: String
    let gender: String
    let hasPortal: Bool
    let id: Int
    let imageURL: String
    let lastName: String
    let portalURL: String
    let teacherShort: String
    
    init(desc: String, firstName: String, gender: String, hasPortal: Bool, id: Int, imageURL: String, lastName: String, portalURL: String, teacherShort: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.desc = desc
        self.firstName = firstName
        self.gender = gender
        self.hasPortal = hasPortal
        self.id = id
        self.imageURL = imageURL
        self.lastName = lastName
        self.portalURL = portalURL
        self.teacherShort = teacherShort
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let desc = value["desc"] as? String,
            let firstName = value["firstName"] as? String,
            let gender = value["gender"] as? String,
            let hasPortal = value["hasPortal"] as? Bool,
            let id = value["id"] as? Int,
            let imageURL = value["imageURL"] as? String,
            let lastName = value["lastName"] as? String,
            let portalURL = value["portalURL"] as? String,
            let teacherShort = value["teacherShort"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.desc = desc
        self.firstName = firstName
        self.gender = gender
        self.hasPortal = hasPortal
        self.id = id
        self.imageURL = imageURL
        self.lastName = lastName
        self.portalURL = portalURL
        self.teacherShort = teacherShort
    }
    
    func toAnyObject() -> Any {
        return [
            "desc": desc,
            "firstName": firstName,
            "gender": gender,
            "hasPortal": hasPortal,
            "id": id,
            "imageURL": imageURL,
            "lastName": lastName,
            "portalURL": portalURL,
            "teacherShort": teacherShort
        ]
    }
}
