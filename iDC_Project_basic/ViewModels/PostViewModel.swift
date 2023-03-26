//
//  PostViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import Foundation

class PostViewModel {
    private var post: PostForm
    let firebase = FirebaseDB()
    
    init() {
        self.post = PostForm(id: "", title: "", description: "", comment: [], time: "")
    }
    
    init(_ post: PostForm) {
        self.post = post
    }
}

// MARK: - Input
extension PostViewModel {
    
    func writePost(title: String, description: String, time: String) {
        let newWritePost: WritePostForm = WritePostForm(title: title, description: description, comment: [], time: time)
        firebase.writePost(newWritePost)
    }
    
    func writeComment(documentID: String, comment: [String]) {
        firebase.writeComment(documentID: documentID, comment: comment)
    }
    
    func getDocument(documentID: String) async throws {
        let post = try await firebase.getDocument(documentID: documentID)
        self.post = post
    }
}

// MARK: - Output
extension PostViewModel {
    
    var id: String { return self.post.id }
    var title: String { return self.post.title }
    var description: String { return self.post.description }
    var comment: [String] { return self.post.comment }
    var time: String { return self.post.time }
}

extension PostViewModel {
    
    var NumberOfSections: Int {
        return 1
    }
    
    func postDetailNumberOfRowInSection(_ section: Int) -> Int {
        return 1
    }
    
    func commentNumberOfRowsInSection(_ section: Int) -> Int {
        return self.comment.count
    }
    
    func commentAtIndex(_ index: Int) -> String {
        let comment = self.comment.reversed()[index - 1]
        return comment
    }
}
