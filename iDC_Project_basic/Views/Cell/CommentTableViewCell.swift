//
//  CommentTableViewCell.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/15.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    let commentLabel: UILabel = {
        let cl = UILabel()
        cl.font = UIFont.systemFont(ofSize: 16)
        cl.textColor = .lightGray
        cl.numberOfLines = 0
        
        return cl
    }()
    
    func setupUI() {
        self.addSubview(commentLabel)
    }
    
    // MARK: - Setup Constraints
    func setupLayout() {
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commentLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            commentLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            commentLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
}
