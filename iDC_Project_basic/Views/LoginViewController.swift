//
//  LoginViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController, ASAuthorizationControllerPresentationContextProviding {
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel = LoginViewModel()
        
        setupUI()
        setupLayout()
        loginCheck()
    }
    
    // MARK: - Function Code
    @objc func handleAuthorizationAppleIDButtonPress() {
        loginViewModel.loginWithApple()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func loginCheck() {
        loginViewModel.onLoginSuccess = { [weak self] in
            let homeVC = TabBarController()
            homeVC.modalPresentationStyle = .fullScreen
            self?.present(homeVC, animated: true)
        }
        
        loginViewModel.onLoginFailure = { [weak self] error in
            self?.showAlert("Login fail", "Sign in with apple.")
            print(error)
        }
    }
    
    // MARK: - Setup UI
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "IMG_1622")
        
        return iv
    }()
    
    let authorizationButton: ASAuthorizationAppleIDButton = {
        let ab = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .white)
        ab.cornerRadius = 4
        
        return ab
    }()
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.view.addSubview(imageView)
        self.view.addSubview(authorizationButton)
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -60)
        ])
        NSLayoutConstraint.activate([
            authorizationButton.heightAnchor.constraint(equalToConstant: 40),
            authorizationButton.widthAnchor.constraint(equalToConstant: 200),
            authorizationButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            authorizationButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        ])
    }
}


