//
//  MyPostViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/04/07.
//

import UIKit

class MyPostViewController: UITableViewController {
    
    private let cellId = "PostTableViewCell"
    var postListViewModel: PostListViewModel!
    
    var editButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    
    init(postListViewModel: PostListViewModel!) {
        self.postListViewModel = postListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNavigation()
        navigationItemSetting()
        setupUI()
        //        setupRefreshController()
        loadData()
    }
    
    // MARK: -Load Data
    @objc func loadData() {
        Task(priority: .userInitiated) {
            do {
                try await postListViewModel.getMyPost()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("Load Data Success")
            } catch {
                print("Error Load Data: \(error.localizedDescription)")
            }
        }
    }
    
//    // MARK: - Function Code
//    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
//        navigationItem.rightBarButtonItem = doneButton
//        self.tableView.setEditing(true, animated: true)
//    }
//
//    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
//        navigationItem.rightBarButtonItem = editButton
//        self.tableView.setEditing(false, animated: true)
//    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Posts written by me"
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    func navigationItemSetting() {
//        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped(_:)))
//        doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: nil)
//        self.navigationItem.rightBarButtonItems = [editButton]
        self.navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - TableView Code
    override func numberOfSections(in tableView: UITableView) -> Int {
        return postListViewModel == nil ? 0 : postListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostTableViewCell else { fatalError("PostTableViewCell not found") }
        
        let postViewModel = self.postListViewModel.postAtIndex(indexPath.row)
        cell.selectionStyle = .none
        cell.titleLabel.text = postViewModel.title
        cell.descriptionLabel.text = postViewModel.description
        cell.timeLabel.text = postViewModel.time
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextVC = PostDetailViewController()
        NextVC.postViewModel = self.postListViewModel.postAtIndex(indexPath.row)
        navigationController?.pushViewController(NextVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertVC = UIAlertController(title: "Delete Post", message: "Are you sure you want to delete the post?", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in
                let documentID = self.postListViewModel.postAtIndex(indexPath.row).id
                self.postListViewModel.deletePost(documentID: documentID)
                self.loadData()
                NotificationCenter.default.post(name: NSNotification.Name("deletePostNotification"), object: nil)
            })
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Setup UI
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.tableView.rowHeight = 80
    }
    
}
