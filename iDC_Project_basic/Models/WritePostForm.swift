//
//  WritePostForm.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/21.
//

import Foundation

struct WritePostForm {
    var UID: String
    var title: String
    var description: String
    var comment: [String]
    var time: String
    
    init (UID: String, title: String, description: String, comment: [String], time: String) {
        self.UID = UID
        self.title = title
        self.description = description
        self.comment = comment
        self.time = time
    }
}
