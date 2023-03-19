//
//  LoginViewController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
        setupLayout()
    }
    
    // MARK: - Function Code
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
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
    
    /*
    let LoginButton: UIButton = {
        let lb = UIButton()
        lb.backgroundColor = .white
        lb.layer.cornerRadius = 4
        lb.setTitle(" Sign in with Apple", for: .normal)
        lb.setTitleColor(.black, for: .normal)
        
        return lb
    }()
     */
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.view.addSubview(imageView)
//        self.view.addSubview(LoginButton)
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
