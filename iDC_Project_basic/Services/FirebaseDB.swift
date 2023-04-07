//
//  postService.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/11.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import UserNotifications
import SwiftKeychainWrapper

class FirebaseDB {
    
    var db: Firestore = Firestore.firestore()
    var listener: ListenerRegistration?
    var posts: [PostForm] = []
    
    // MARK: - Get Data with DB
    func getPost() async throws -> [PostForm] {
        let collectionRefernece = db.collection("Post")
        let querySnapshot = try await collectionRefernece
            .order(by: "time", descending: true)
            .getDocuments()
        
        var posts: [PostForm] = []
        for document in querySnapshot.documents {
            guard let post = PostForm(dictionary: document.data(), documentID: document.documentID) else { throw NSError(domain: "Error getting documents", code: 404) }
            posts.append(post)
        }
        
        print("Get Post Success")
        
        return posts
    }
    
    func getDocument(documentID: String) async throws -> PostForm {
        let documentRefernece = db.collection("Post").document(documentID)
        let document = try await documentRefernece.getDocument()
        guard let post = PostForm(dictionary: document.data()!, documentID: document.documentID) else { throw NSError(domain: "Error getting documents", code: 404) }
        
        return post
    }
    
    func searchPost(keyword: String) async throws -> [PostForm] {
        
        let documentRefernece = db.collection("Post")
        let querySnapshot = try await documentRefernece
            .order(by: "time", descending: true)
            .getDocuments()
        
        var posts: [PostForm] = []
        for document in querySnapshot.documents {
            guard let post = PostForm(dictionary: document.data(), documentID: document.documentID) else { throw NSError(domain: "Error getting documents", code: 404) }
            if post.description.contains(keyword) || post.title.contains(keyword) {
                posts.append(post)
            }
        }
        print("Get Post Scuccess")
        
        return posts
    }
    
    // MARK: - Add Data in DB
    func writePost(_ newPost: WritePostForm) {
        let collectionRefernece = db.collection("Post")
        let newPost = WritePostForm(UID: newPost.UID, title: newPost.title, description: newPost.description, comment: newPost.comment, time: newPost.time)
        collectionRefernece
            .addDocument(data: [
                "UID": newPost.UID,
                "title": newPost.title,
                "description": newPost.description,
                "comment": newPost.comment,
                "time": newPost.time
            ]) { error in
                if let error = error {
                    print("Error write post: \(error.localizedDescription)")
                } else {
                    print("write post success")
                }
            }
    }
    
    func writeComment(documentID: String, comment: [String]) {
        let documentRefernece = db.collection("Post").document(documentID)
        documentRefernece
            .updateData([
                "comment" : comment
            ]) { error in
                if let error = error {
                    print("Error write comment: \(error.localizedDescription)")
                } else {
                    print("write comment success")
                }
            }
    }
}
