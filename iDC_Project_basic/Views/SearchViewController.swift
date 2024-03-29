//
//  SearchViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/19.
//

import UIKit

class SearchViewController: UIViewController {
    
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
                
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        
        observeSearchButtonTapped()
        setupUI()
        setupLayout()
    }
    
    // MARK: -Load Data
    func observeSearchButtonTapped() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchButtonTapped(_:)), name: NSNotification.Name("searchButtonTappedNotification"), object: nil)
    }
    
    @objc func searchButtonTapped(_ notification: Notification) {
        guard let keyword = notification.object as? String else { return }
        
        Task(priority: .userInitiated) {
            do {
                try await postListViewModel.searchPost(keyword: keyword)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.endEditing(true)
                }
                print("Search Data Success")
            } catch {
                print("Error Search Data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Setup UI
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.rowHeight = 80
        
        return tv
    }()
    
    func setupUI() {
        self.view.backgroundColor = .systemBackground
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
    
    // MARK: - TableView Code
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
//        navigationController?.pushViewController(NextVC, animated: true)
        present(NextVC, animated: true)
    }
}

