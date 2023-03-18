//
//  PostForm.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import Foundation

struct PostForm {
    var id: String
    var title: String
    var description: String
    var comment: [String]
    var time: String
    
    init?(dictionary: [String:Any], documentID: Any) {
        self.id = documentID as! String
        self.title = dictionary["title"] as! String
        self.description = dictionary["description"] as! String
        self.comment = dictionary["comment"] as! [String]
        self.time = dictionary["time"] as! String
    }
}

struct WritePostForm {
    var title: String
    var description: String
    var comment: [String]
    var time: String
    
    init (title: String, description: String, comment: [String], time: String) {
        self.title = title
        self.description = description
        self.comment = comment
        self.time = time
    }
}
