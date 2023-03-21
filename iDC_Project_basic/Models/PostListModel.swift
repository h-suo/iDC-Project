//
//  PostListModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/21.
//

import Foundation

// MARK: - PostList Model
class PostListModel {
    
    let firebaseDB = FirebaseDB()
    var postListVM: PostListViewModel?
    
    func getPost(completion: @escaping(Result<Void, Error>) -> Void) {
        Task(priority: .userInitiated) {
            do {
                let postList = try await self.firebaseDB.getPost()
                self.postListVM = PostListViewModel(postList: postList)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
