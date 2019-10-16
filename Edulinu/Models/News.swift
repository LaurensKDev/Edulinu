//
//  News.swift
//  Edulinu
//
//  Created by Laurens on 15.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation
import Firebase

struct News {
    
    let ref: DatabaseReference?
    let key: String
    let author: String
    let desc: String
    let imageUrl: String
    let newsId: Int
    let text: String
    let title: String
    
    init(author: String, desc: String, imageUrl: String, newsId: Int, text: String, title: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.author = author
        self.desc = desc
        self.imageUrl = imageUrl
        self.newsId = newsId
        self.text = text
        self.title = title
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let author = value["author"] as? String,
            let desc = value["desc"] as? String,
            let imageUrl = value["imageUrl"] as? String,
            let newsId = value["newsId"] as? Int,
            let text = value["text"] as? String,
            let title = value["title"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.author = author
        self.desc = desc
        self.imageUrl = imageUrl
        self.newsId = newsId
        self.text = text
        self.title = title
    }
    
    func toAnyObject() -> Any {
        return [
            "author": author,
            "desc": desc,
            "imageUrl": imageUrl,
            "newsId": newsId,
            "text": text,
            "title": title
        ]
    }
}
