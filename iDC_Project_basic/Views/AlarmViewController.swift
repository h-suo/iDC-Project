//
//  AlarmViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class AlarmViewController: UITableViewController {
    
    var postViewModel: PostViewModel!
    let cellId = "AlarmTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
                
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 80

        setupNavigation()
        observeUpdataPost()
    }
    
    // MARK: - Update Data Check
    func observeUpdataPost() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("updatePostNotification"), object: nil)
    }
    
    @objc func updateData(_ notification: Notification) {
        guard let post = notification.object as? PostForm else { return }
        
        self.postViewModel = PostViewModel(post)
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Alarm"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
    }
    
    // MARK: - TableView Code
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.postViewModel == nil ? 0 : self.postViewModel.NumberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlarmTableViewCell else { fatalError("AlarmTableViewCell not found") }
        
        return cell
    }
}
