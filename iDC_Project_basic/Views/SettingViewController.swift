//
//  SettingViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class SettingViewController: UITableViewController {
    
    private let cellId = "SettingImageTableViewCell"
    let settingViewModel: SettingViewModel!
    
    init(style: UITableView.Style, settingViewModel: SettingViewModel!) {
        self.settingViewModel = settingViewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.isScrollEnabled = false
        
        setupNavigation()
        navigationItemSetting()
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationItem.title = "Setting"
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    func navigationItemSetting() {
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
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
        guard let imageCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SettingTableViewCell else { fatalError("SettingImageTableViewCell not found") }
        
        switch indexPath.section {
        case settingViewModel.themeSettingSection:
            if let appearance = UserDefaults.standard.string(forKey: "Appearance") {
                if appearance == "Light", indexPath.row == 0 {
                    imageCell.itemImageView.image = UIImage(systemName: "checkmark.circle.fill")
                } else if appearance == "Dark", indexPath.row == 1 {
                    imageCell.itemImageView.image = UIImage(systemName: "checkmark.circle.fill")
                }
            }
            imageCell.label.text = settingViewModel.sections[settingViewModel.themeSettingSection][indexPath.row]
            imageCell.selectionStyle = .none
            return imageCell
        case settingViewModel.postSettingSection:
            imageCell.label.text = settingViewModel.sections[settingViewModel.postSettingSection][indexPath.row]
            imageCell.itemImageView.image = UIImage(systemName: "chevron.compact.right")
            imageCell.itemImageView.tintColor = .systemGray
            imageCell.selectionStyle = .none
            return imageCell
        case settingViewModel.accountSettingSection:
            imageCell.label.text = settingViewModel.sections[settingViewModel.accountSettingSection][indexPath.row]
            imageCell.itemImageView.image = UIImage(systemName: "")
            imageCell.label.textColor = .systemRed
            imageCell.selectionStyle = .none
            return imageCell
        default:
            return imageCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == settingViewModel.themeSettingSection {
            if let cell = tableView.cellForRow(at: indexPath) as? SettingTableViewCell {
                cell.itemImageView.image = UIImage(systemName: "checkmark.circle.fill")
                self.viewWillAppear(true)
            }
            
            for row in 0..<settingViewModel.settingNumberOfRowInSection(indexPath.section) {
                let otherIndexPath = IndexPath(row: row, section: indexPath.section)
                if otherIndexPath != indexPath, let otherCell = tableView.cellForRow(at: otherIndexPath) as? SettingTableViewCell {
                    otherCell.itemImageView.image = UIImage(systemName: "circle")
                }
            }
            
            if indexPath.row == 0 {
                settingViewModel.lightThemeSelected()
                view.window?.overrideUserInterfaceStyle = .light
            } else {
                settingViewModel.darkThemeSelected()
                view.window?.overrideUserInterfaceStyle = .dark
            }
        }
        
        if indexPath.section == settingViewModel.postSettingSection {
            navigationController?.pushViewController(MyPostViewController(postListViewModel: PostListViewModel()), animated: true)
        }
        
        //        if indexPath.section == settingViewModel.accountSettingSection {
        //            if indexPath.row == 0 {
        //                if let url = URL(string: "https://github.com/h-suo/TEST-UIKit/blob/main/Test%20UIKit.md") {
        //                    UIApplication.shared.open(url, options: [:])
        //                }
        //            } else {
        //
        //            }
        //        }
    }
}
