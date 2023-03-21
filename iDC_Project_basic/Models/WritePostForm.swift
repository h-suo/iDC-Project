//
//  WritePostForm.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/21.
//

import Foundation

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
