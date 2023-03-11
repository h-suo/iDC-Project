//
//  PostForm.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import Foundation

struct PostForm: Decodable {
    var id: Int
    var title: String
    var description: String
    var comment: [String]
    var time: String
}

extension PostForm {
    static let EMPTY = PostForm(id: 0, title: "title", description: "description", comment: [], time: "00:00")
}
