//
//  postService.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/11.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirebaseDB {
    
    var db: Firestore = Firestore.firestore()
    var posts: [PostForm] = []
    
    // MARK: - Function Code
    func getPost() async throws -> [PostForm] {
        let querySnapshot = try await db.collection("Post").order(by: "time", descending: true).getDocuments()
        var posts: [PostForm] = []
        for document in querySnapshot.documents {
            guard let post = PostForm(dictionary: document.data(), documentID: document.documentID) else { throw NSError(domain: "Error getting documents", code: 404) }
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
    
    func writePost(title: String, description: String, time: String) {
        let newPost = WritePostForm(title: title, description: description, comment: [], time: time)
        db.collection("Post").addDocument(data: [
            "title": newPost.title,
            "description": newPost.description,
            "comment": newPost.comment,
            "time": newPost.time
        ]) { err in
            if let err = err {
                print("Error write post: \(err)")
            } else {
                print("write post success")
            }
        }
    }
    
    func writeComment(documentID: String, comment: [String]) {
        
        let documentRefernece = db.collection("Post").document(documentID)
        documentRefernece.updateData([
            "comment" : comment
        ]) { err in
            if let err = err {
                print("Error write comment: \(err)")
            } else {
                print("write comment success")
            }
        }
    }
    
    func getDocument(documentID: String) async throws -> PostForm {
        
        let documentRefernece = db.collection("Post").document(documentID)
        let document = try await documentRefernece.getDocument()
        guard let post = PostForm(dictionary: document.data()!, documentID: document.documentID) else { throw NSError(domain: "Error getting documents", code: 404) }
        
        return post
    }
}
