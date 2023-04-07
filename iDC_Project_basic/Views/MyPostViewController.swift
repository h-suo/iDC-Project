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
        setupRefreshController()
        loadData()
    }
    
    // MARK: -Load Data
    @objc func loadData() {
        Task(priority: .userInitiated) {
            do {
                try await postListViewModel.getPost()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("Load Data Success")
            } catch {
                print("Error Load Data: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func reloadData() {
        Task(priority: .userInitiated) {
            do {
                try await postListViewModel.getPost()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
                print("Reload Data Success")
            } catch {
                print("Error Reload Data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Function Code
    @IBAction func settingButtonTapped() {
        
    }
    
    // MARK: - Setup TableView Refresh Controller
    func setupRefreshController() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Posts written by me"
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    func navigationItemSetting() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(settingButtonTapped))
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [searchButton]
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
    
    
    // MARK: - Setup UI
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.tableView.rowHeight = 80
    }
    
}
