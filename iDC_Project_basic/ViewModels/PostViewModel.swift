//
//  PostViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import Foundation

// MARK: - Post ViewModel
struct PostViewModel {
    private let post: PostForm
}

extension PostViewModel {
    init(_ post: PostForm) {
        self.post = post
    }
}

extension PostViewModel {
    
    var id: String { return self.post.id }
    var title: String { return self.post.title }
    var description: String { return self.post.description }
    var comment: [String] { return self.post.comment }
    var time: String { return self.post.time }
}

extension PostViewModel {
    
    var commentNumberOfSections: Int {
        return 1
    }
    
    func commentNumberOfRowsInSection(_ section: Int) -> Int {
        return self.comment.count
    }
    
    func commentAtIndex(_ index: Int) -> String {
        let comment = self.comment[index]
        return comment
    }
}
