//
//  AlarmTableViewCell.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/04/02.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    let alarmImageView: UIImageView = {
        let aiv = UIImageView()
        aiv.image = UIImage(systemName: "bell.fill")
        
        return aiv
    }()
    
    let alarmLabel: UILabel = {
        let al = UILabel()
        al.font = UIFont.systemFont(ofSize: 20)
        al.text = "The post you wrote has been updated."
        al.numberOfLines = 0
        
        return al
    }()
    
    func setupUI() {
        self.addSubview(alarmImageView)
        self.addSubview(alarmLabel)
    }
    
    // MARK: - Setup Constraints
    func setupLayout() {
        alarmImageView.translatesAutoresizingMaskIntoConstraints = false
        alarmLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alarmImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            alarmImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            alarmImageView.heightAnchor.constraint(equalToConstant: 24),
            alarmImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            alarmLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            alarmLabel.leadingAnchor.constraint(equalTo: alarmImageView.trailingAnchor, constant: 16),
            alarmLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
