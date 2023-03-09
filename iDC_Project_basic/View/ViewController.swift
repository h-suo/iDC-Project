//
//  ViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "HomeTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = nil
        
        setupUI()
        setupNavigation()
        navigationItemSetting()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        self.view.backgroundColor = .black
//        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.rowHeight = 80
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
}

