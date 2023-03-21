//
//  SettingViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class SettingViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        setupNavigation()
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Setting"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
    }
    
    // MARK: - TableView Code
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}
