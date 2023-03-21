//
//  SearchViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/19.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var postListViewModel: PostListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    let cellId = "PostTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure search bar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Please enter your keyword."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        // Configure table view
        tableView.delegate = self
        tableView.dataSource = self
        
        postListViewModel = PostListViewModel()
        
        setupNavigation()
        setupUI()
        setupLayout()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        print(keyword)
                
        postListViewModel.searchPost(keyword: keyword, completion: { result in
            switch result {
            case .success:
                self.tableView.reloadData()
                print("Search Data Success")
            case .failure(let err):
                print("Error search Data: \(err)")
            }
        })
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Setup UI
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .black
        
        return tv
    }()
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.rowHeight = 80
        self.view.addSubview(tableView)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return postListViewModel == nil ? 0 : self.postListViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PostTableViewCell else { fatalError("PostTableViewCell not found") }
        
        let post = self.postListViewModel.postAtIndex(indexPath.row)
        cell.selectionStyle = .none
        cell.titleLabel.text = post.title
        cell.descriptionLabel.text = post.description
        cell.timeLabel.text = post.time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextVC = PostDetailViewController()
        NextVC.postViewModel = self.postListViewModel.postAtIndex(indexPath.row)
        navigationController?.pushViewController(NextVC, animated: true)
    }
}

