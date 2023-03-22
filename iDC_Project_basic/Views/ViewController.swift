//
//  ViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class ViewController: UITableViewController {
    
    var postListViewModel: PostListViewModel!
    let cellId = "PostTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        postListViewModel = PostListViewModel()
        
        setupNavigation()
        navigationItemSetting()
        setupUI()
        setupRefreshController()
        loadData()
        observeWritePost()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        loadData()
    }
    
    // MARK: - Load Data
    func observeWritePost() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name("writePostNotification"), object: nil)
    }
    
    @objc func loadData() {
        postListViewModel.getPost { result in
            switch result {
            case .success:
                self.tableView.reloadData()
                print("Load Data Success")
            case .failure(let err):
                print("Error Load Data: \(err)")
            }
        }
    }
    
    @IBAction func reloadData() {
        postListViewModel.getPost { result in
            switch result {
            case .success:
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                print("Reload Data Success")
            case .failure(let err):
                print("Error Reload Data: \(err)")
            }
        }
    }
    
    // MARK: - Function Code
    @IBAction func plusButtonTapped() {
        self.navigationController?.pushViewController(AddPostViewController(), animated: true)
    }
    /*
     @IBAction func searchButtonTapped() {
     let searchVC = UISearchController(searchResultsController: SearchViewController())
     searchVC.obscuresBackgroundDuringPresentation = true
     present(searchVC, animated: true)
     }
     */
    
    // MARK: - Setup TableView Refresh Controller
    func setupRefreshController() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        self.tableView.refreshControl?.tintColor = .white
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
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
    /*
     let imageView: UIImageView = {
     let iv = UIImageView()
     iv.image = UIImage(systemName: "plus.circle")
     iv.tintColor = .gray
     iv.backgroundColor = .clear
     
     return iv
     }()
     */
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.rowHeight = 80
        /*
         self.view.addSubview(imageView)
         imageView.isUserInteractionEnabled = true
         imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusViewTapped)))
         */
    }
    
    // MARK: - Setup Layout
    /*
     func setupLayout() {
     imageView.translatesAutoresizingMaskIntoConstraints = false
     
     NSLayoutConstraint.activate([
     imageView.heightAnchor.constraint(equalToConstant: 60),
     imageView.widthAnchor.constraint(equalToConstant: 60),
     imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
     imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
     ])
     }
     */
}
