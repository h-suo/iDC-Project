//
//  LoginViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class LoginViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
//        setupConstraints()
    }
        
    // MARK: - Setup UI
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "IMG_1622")
        
        return iv
    }()
    
    let LoginButton: UIButton = {
        let lb = UIButton()
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 4
        lb.setTitle(" Sign in with Apple", for: .normal)
        lb.setTitleColor(.black, for: .normal)
        
        return lb
    }()
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.view.addSubview(imageView)
        self.view.addSubview(LoginButton)
    }
    
    // MARK: - Setup Constraints
//    func setupConstraints() {
//        imageView.snp.makeConstraints { make in
//            make.width.equalTo(120)
//            make.height.equalTo(120)
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(300)
//        }
//        SingInButton.snp.makeConstraints { make in
//            make.width.equalTo(200)
//            make.height.equalTo(40)
//            make.centerX.equalToSuperview()
//            make.top.equalTo(imageView.snp.bottom).offset(40)
//        }
//    }
}
