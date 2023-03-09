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
        setupLayout()
    }
        
    // MARK: - Setup UI
    let imageView: UIImageView = {
        let iv = UIImageView()
//        iv.image = UIImage(named: "pencil.circle.fill")
        iv.backgroundColor = .white
        
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
    
    // MARK: - Setup Layout
    func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -60)
        ])
        NSLayoutConstraint.activate([
            LoginButton.heightAnchor.constraint(equalToConstant: 40),
            LoginButton.widthAnchor.constraint(equalToConstant: 200),
            LoginButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            LoginButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        ])
    }    
}
