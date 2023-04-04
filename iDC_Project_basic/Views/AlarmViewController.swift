//
//  AlarmViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class AlarmViewController: UITableViewController {
    
    var alarmViewModel: AlarmViewModel! = AlarmViewModel()
    let cellId = "AlarmTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 80

        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alarmViewModel.observeUpdataPost()
        tableView.reloadData()
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Alarm"
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
    }
    
    // MARK: - TableView Code
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.alarmViewModel == nil ? 0 : self.alarmViewModel.NumberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmViewModel.alarmPostNumberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlarmTableViewCell else { fatalError("AlarmTableViewCell not found") }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NextVC = PostDetailViewController()
        NextVC.postViewModel = self.alarmViewModel.alarmPostAtIndex(indexPath.row)
        navigationController?.pushViewController(NextVC, animated: true)
    }
}
