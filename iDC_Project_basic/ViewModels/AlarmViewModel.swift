//
//  AlarmViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/04/04.
//

import Foundation

class AlarmViewModel {
    private var alarmPosts: [PostForm] = []
}

extension AlarmViewModel {
    // MARK: - Update Data Check
    func observeUpdataPost() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("updatePostNotification"), object: nil)
    }
    
    @objc func updateData(_ notification: Notification) {
        guard let post = notification.object as? PostForm else { return }
        
        self.alarmPosts.append(post)
    }
}

extension AlarmViewModel {
    
    var NumberOfSections: Int {
        return 1
    }
    
    func alarmPostNumberOfRowsInSection(_ section: Int) -> Int {
        return self.alarmPosts.count
    }
    
    func alarmPostAtIndex(_ index: Int) -> PostViewModel {
        let post = self.alarmPosts[index]
        return PostViewModel(post)
    }
}
