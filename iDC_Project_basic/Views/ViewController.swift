//
//  ViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class ViewController: UITableViewController {
    
    var postListVM: PostListViewModel!
    let cellId = "HomeTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavigation()
        navigationItemSetting()
        setupUI()
        setupLayout()
        setupRefreshController()
        
        roadData()
    }
    
    // MARK: - Road Data
    func roadData() {
        Task(priority: .userInitiated) {
            do {
                let postList = try await FirebaseDB().getPost()
                self.postListVM = PostListViewModel(postList: postList)
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
                let postList = try await FirebaseDB().getPost()
                self.postListVM = PostListViewModel(postList: postList)
                self.tableView.reloadData()
                refreshControl?.endRefreshing()
                print("reload Data success")
            } catch {
                print("Error reloading post: \(error)")
            }
        }
    }
    
    // MARK: - Function Code
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
    
    // MARK: - TableView Code
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.postListVM == nil ? 0 : self.postListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HomeTableViewCell else { fatalError("HomeTableViewCell not found") }
        
        let postVM = self.postListVM.postAtIndex(indexPath.row)
        cell.selectionStyle = .none
        cell.titleLabel.text = postVM.title
        cell.descriptionLabel.text = postVM.description
        cell.timeLabel.text = postVM.time
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextVC = PostDetailiViewController()
        NextVC.postVM = self.postListVM.postAtIndex(indexPath.row)
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
