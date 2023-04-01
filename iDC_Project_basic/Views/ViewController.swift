//
//  ViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class ViewController: UITableViewController {
    
    var postListViewModel: PostListViewModel!
    let searchController = UISearchController(searchResultsController: SearchViewController(postListViewModel: PostListViewModel()))
    let cellId = "PostTableViewCell"
    
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
        
        searchController.searchBar.delegate = self
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNavigation()
        navigationItemSetting()
        setupUI()
        setupRefreshController()
        loadData()
        observeWritePost()
        observeTabBarTapped()
        setupSearchBar()
    }
    
    // MARK: -Load Data
    func observeWritePost() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name("writePostNotification"), object: nil)
    }
    
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
    @IBAction func plusButtonTapped() {
        self.navigationController?.pushViewController(AddPostViewController(postViewModel: PostViewModel()), animated: true)
    }
    
    func observeTabBarTapped() {
        NotificationCenter.default.addObserver(self, selector: #selector(homeTabBarTapped), name: NSNotification.Name("homeTabBarTappedNotification"), object: nil)
    }
    
    @IBAction func homeTabBarTapped() {
        tableView.setContentOffset(CGPoint(x: 0, y: -tableView.adjustedContentInset.top), animated: true)
    }
    
    // MARK: - Setup TableView Refresh Controller
    func setupRefreshController() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    // MARK: -Setup SearchBar
    func setupSearchBar() {
        searchController.searchBar.placeholder = "Please enter your keyword."
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.title = "iDC"
    }
    
    func navigationItemSetting() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
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

extension ViewController: UISearchBarDelegate {
    
    // MARK: - Search Action
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("searchButtonTappedNotification"), object: keyword)
    }
}
