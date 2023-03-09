//
//  PostViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class PostDetailiViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
//        setupConstraints()
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.overrideUserInterfaceStyle = .dark
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Setup UI
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = .systemFont(ofSize: 20)
        
        return tl
    }()
    
    let tiemLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = .gray
        
        return tl
    }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 18)
        tv.textColor = .lightGray
        tv.isEditable = false
        
        return tv
    }()

    func setupUI() {
        self.view.backgroundColor = .black
        self.view.addSubview(titleLabel)
        self.view.addSubview(tiemLabel)
        self.view.addSubview(textView)
    }

//    // MARK: - Setup Constraints
//    func setupConstraints() {
//        titleLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//        }
//        tiemLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.top.equalTo(titleLabel.snp.bottom)
//        }
//        textView.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(12)
//            make.trailing.equalToSuperview().offset(-12)
//            make.top.equalTo(tiemLabel.snp.bottom).offset(12)
//            make.height.equalTo(300)
//        }
//    }
}
