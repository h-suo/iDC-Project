//
//  SettingTableViewCell.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/29.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
        
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
        
        return cl
    }()
    
    let itemImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "circle")
        
        return iv
    }()
    
    func setupUI() {
        self.backgroundColor = .quaternarySystemFill
        self.addSubview(label)
        self.addSubview(itemImageView)
    }
    
    // MARK: - Setup Constraints
    func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            itemImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            itemImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            itemImageView.heightAnchor.constraint(equalToConstant: 20),
            itemImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
