//
//  PostViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class PostViewModel {
    
    static let shared = PostViewModel()
    
    var db: Firestore = Firestore.firestore()
    var posts: [PostForm] = []
    
    /*
    init(posts: [PostForm]) {
        self.posts = posts
    }
     */
    
    // MARK: - Function Code
    func getPost() async throws -> [PostForm] {
        let querySnapshot = try await db.collection("Post").order(by: "time", descending: true).getDocuments()
        var posts: [PostForm] = []
        for document in querySnapshot.documents {
            guard let post = PostForm(dictionary: document.data()) else { throw NSError(domain: "Error getting documents", code: 404) }
            posts.append(post)
        }
        
        /*
         db.collection("Post").getDocuments() { (querySnapshot, err) in
         if let err = err {
         print("Error getting documents: \(err)")
         } else {
         for document in querySnapshot!.documents {
         
         guard let post = PostForm(dictionary: document.data()) else { return }
         self.posts.append(post)
         print(post)
         }
         }
         }*/
        
        return posts
    }
    
    func writePost(id: Int, title: String, description: String, time: String) {
        let newPost = PostForm(id: id, title: title, description: description, comment: [], time: time)
        db.collection("Post").addDocument(data: [
            "id": newPost.id as Any,
            "title": newPost.title as Any,
            "description": newPost.description as Any,
            "comment": newPost.comment as Any,
            "time": newPost.time as Any
        ]) { err in
            if let err = err {
                print(err)
            } else {
                print("writePost success")
            }
        }
    }
    
}
