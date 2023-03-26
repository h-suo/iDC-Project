//
//  PostListViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/21.
//

import Foundation

class PostListViewModel {
    
    private var postList: [PostForm] = []
    let firebase = FirebaseDB()
}

// MARK: - IntPut
extension PostListViewModel {

    func getPost() async throws {
        let postList = try await firebase.getPost()
        self.postList = postList
    }
    
    func searchPost(keyword: String) async throws {
        let postList = try await firebase.searchPost(keyword: keyword)
        self.postList = postList
    }
}

// MARK: - Output
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
