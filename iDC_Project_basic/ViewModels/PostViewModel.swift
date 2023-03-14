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
    
//    init(posts: [PostForm]) {
//        self.posts = posts
//    }
    
    func getPost() async throws -> [PostForm] {
        let querySnapshot = try await db.collection("Post").getDocuments()
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
}
