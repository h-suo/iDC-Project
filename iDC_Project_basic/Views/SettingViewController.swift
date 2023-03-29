//
//  SettingViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class SettingViewController: UITableViewController {
    
    let imageCellId = "SettingImageTableViewCell"
    let toggleCellId = "SettingToggleTableViewCell"
    let settingViewModel: SettingViewModel = SettingViewModel()
    
    override init(style: UITableView.Style) {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        tableView.register(SettingImageTableViewCell.self, forCellReuseIdentifier: imageCellId)
        tableView.register(SettingToggleTableViewCell.self, forCellReuseIdentifier: toggleCellId)
        tableView.isScrollEnabled = false
        
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
        
        return settingViewModel == nil ? 0 : settingViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingViewModel.titleForHeaderInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingViewModel.settingNumberOfRowInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imageCell = tableView.dequeueReusableCell(withIdentifier: imageCellId, for: indexPath) as? SettingImageTableViewCell else { fatalError("SettingImageTableViewCell not found") }
        guard let toggleCell = tableView.dequeueReusableCell(withIdentifier: toggleCellId, for: indexPath) as? SettingToggleTableViewCell else { fatalError("SettingToggleTableViewCell not found") }
        
        switch indexPath.section {
        case settingViewModel.themeSettingSection:
            imageCell.label.text = settingViewModel.sections[settingViewModel.themeSettingSection][indexPath.row]
            imageCell.selectionStyle = .none
            return imageCell
        case settingViewModel.notificationSettingSection:
            toggleCell.label.text = settingViewModel.sections[ settingViewModel.notificationSettingSection][indexPath.row]
            toggleCell.selectionStyle = .none
            return toggleCell
        case settingViewModel.accountSettingSection:
            imageCell.label.text = settingViewModel.sections[settingViewModel.accountSettingSection][indexPath.row]
            imageCell.itemImageView.image = UIImage(systemName: "")
            imageCell.selectionStyle = .none
            return imageCell
        default:
            return imageCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == settingViewModel.themeSettingSection {
            if let cell = tableView.cellForRow(at: indexPath) as? SettingImageTableViewCell {
                cell.itemImageView.image = UIImage(systemName: "checkmark.circle.fill")
            }
            
            for row in 0..<tableView.numberOfRows(inSection: indexPath.section) {
                let otherIndexPath = IndexPath(row: row, section: indexPath.section)
                if otherIndexPath != indexPath, let otherCell = tableView.cellForRow(at: otherIndexPath) as? SettingImageTableViewCell {
                    otherCell.itemImageView.image = UIImage(systemName: "circle")
                }
            }
        }
    }
    
    
    
}
