//
//  PostForm.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import Foundation

struct PostForm {
    var id: Int?
    var title: String?
    var description: String?
    var comment: [String]?
    var time: String?
    
    init (id: Int, title: String, description: String, comment: [String], time: String) {
        self.id = id
        self.title = title
        self.description = description
        self.comment = comment
        self.time = time
    }
    
    init?(dictionary: [String:Any]) {
        self.id = dictionary["id"] as? Int
        self.title = dictionary["title"] as? String
        self.description = dictionary["description"] as? String
        self.comment = dictionary["comment"] as? [String]
        self.time = dictionary["time"] as? String
    }
}

extension PostForm {
    static let EMPTY = PostForm(id: 0, title: "title", description: "description", comment: [], time: "00:00")
}
