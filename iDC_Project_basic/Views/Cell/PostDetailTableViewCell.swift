//
//  PostDetailTableViewCell.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/22.
//

import UIKit

class PostDetailTableViewCell: UITableViewCell, UITextViewDelegate {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
        
        contentTextView.delegate = self
        contentTextView.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = .systemFont(ofSize: 20)
        
        return tl
    }()
    
    let timeLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = .gray
        
        return tl
    }()
    
    let contentTextView: UITextView = {
        let ctv = UITextView()
        ctv.font = .systemFont(ofSize: 18)
        ctv.textColor = .white
        ctv.isEditable = false
        
        return ctv
    }()
    
    func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(titleLabel)
        self.addSubview(timeLabel)
        self.addSubview(contentTextView)
    }
    
    // MARK: - Setup Constraints
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            timeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            timeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            contentTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            contentTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            contentTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
}
