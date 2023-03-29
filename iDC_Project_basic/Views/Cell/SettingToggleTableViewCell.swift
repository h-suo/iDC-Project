//
//  File.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/29.
//

import UIKit

class SettingToggleTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    let label: UILabel = {
        let cl = UILabel()
        cl.font = UIFont.systemFont(ofSize: 18)
        cl.textColor = .white
        
        return cl
    }()
    
    let toggle: UISwitch = {
        let sw = UISwitch()
        
        return sw
    }()
    
    func setupUI() {
        self.addSubview(label)
        self.contentView.addSubview(toggle)
    }
    
    // MARK: - Setup Constraints
    func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            toggle.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            toggle.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            toggle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}
