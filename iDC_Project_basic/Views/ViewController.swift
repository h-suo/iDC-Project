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
    var posts: [PostForm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        setupUI()
        setupLayout()
        setupRefreshController()
        setupNavigation()
        navigationItemSetting()
        
        roadData()
    }
    
    func roadData() {
        Task(priority: .userInitiated) {
            do {
                posts = try await vm.getPost()
                self.tableView.reloadData()
                print("road Data success")
            } catch {
                print("Error loading post: \(error)")
            }
        }
    }
    
    @IBAction func reloadData() {
        Task(priority: .userInitiated) {
            do {
                posts = try await vm.getPost()
                self.tableView.reloadData()
                print("reload Data success")
                refreshControl?.endRefreshing()
            } catch {
                print("Error loading post: \(error)")
            }
        }
    }
    
    @IBAction func plusViewTapped() {
        self.navigationController?.pushViewController(AddPostViewController(), animated: true)
    }
    
    // MARK: - Setup TableView Refresh Controller
    func setupRefreshController() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        self.tableView.refreshControl?.tintColor = .white
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
        //        guard let count = posts?.count else { return 0 }
        
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        
        //        guard let posts = posts else { return cell}
        
        cell.selectionStyle = .none
        cell.titleLabel.text = posts[indexPath.row].title
        cell.descriptionLabel.text = posts[indexPath.row].description
        cell.timeLabel.text = posts[indexPath.row].time
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextVC = PostDetailiViewController()
        NextVC.post = posts[indexPath.row]
        navigationController?.pushViewController(NextVC, animated: true)
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
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusViewTapped)))
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

