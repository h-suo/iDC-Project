//
//  HomeTableViewCell.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/14.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.numberOfLines = 1
        
        return tl
    }()
    
    let descriptionLabel: UILabel = {
        let dl = UILabel()
        dl.font = UIFont.systemFont(ofSize: 14)
        dl.textColor = .systemGray
        dl.numberOfLines = 1
        
        return dl
    }()
    
    let timeLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = .systemGray
        
        return tl
    }()
    
    func setupUI() {        
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(timeLabel)
    }
    
    // MARK: - Setup Constraints
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -4)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12)
        ])
    }
}
