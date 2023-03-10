//
//  ViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class ViewController: UITableViewController {
    
    var vm: PostViewModel = PostViewModel.shared
    let cellId = "HomeTableViewCell"
    var posts: [PostForm]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = nil
        
        roadData()
        
        setupUI()
        setupLayout()
        setupNavigation()
        navigationItemSetting()
    }
    
    func roadData() {
        Task(priority: .userInitiated) {
            posts = try await vm.getPost()
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.overrideUserInterfaceStyle = .dark
        self.navigationItem.title = "iDC"
    }
    
    func navigationItemSetting() {
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [searchButton]
        self.navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = posts?.count else { return 0 }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        
        guard let posts = posts else { return cell}
        
        print("Cell:\(posts)")
        
        cell.titleLabel.text = posts[indexPath.row].title
        cell.descriptionLabel.text = posts[indexPath.row].description
        cell.timeLabel.text = posts[indexPath.row].time
        
        return cell
    }
    
    
    // MARK: - Setup UI
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "plus.circle")
        iv.tintColor = .gray
        iv.backgroundColor = .clear
        
        return iv
    }()
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.rowHeight = 80
        self.view.addSubview(imageView)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
}

