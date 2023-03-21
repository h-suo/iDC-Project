//
//  PostListViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/21.
//

import Foundation

// MARK: - PostList ViewModel
class PostListViewModel {
    
    private var postList: [PostForm] = []
}

extension PostListViewModel {
    // IntPut
    func getPost(completion: @escaping(Result<Void, Error>) -> Void) {
        Task(priority: .userInitiated) {
            do {
                let postList = try await FirebaseDB().getPost()
                self.postList = postList
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func searchPost(keyword: String, completion: @escaping(Result<Void, Error>) -> Void) {
        Task(priority: .background) {
            do {
                let postList = try await FirebaseDB().searchPost(keyword: keyword)
                print(postList)
                self.postList = postList
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}

// Output
extension PostListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.postList.count
    }
    
    func postAtIndex(_ index: Int) -> PostViewModel {
        let post = self.postList[index]
        return PostViewModel(post)
    }
}
