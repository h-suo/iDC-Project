//
//  AppDelegate.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase code
        FirebaseApp.configure()
        
        // LaunchScreen time set
        Thread.sleep(forTimeInterval: 2)
        
        // apple Login set
        // Create a new UIWindow
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Get user credential state from Apple ID provider
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        if let userID = KeychainWrapper.standard.string(forKey: "userID") {
            appleIDProvider.getCredentialState(forUserID: userID) { credentialState, error in
                DispatchQueue.main.async {
                    var initialViewController: UIViewController
                    switch credentialState {
                    case .authorized:
                        print("User ID is conneted")
                        initialViewController = LoginViewController() // or any other authorized view controller
                    case .revoked, .notFound, .transferred:
                        print("User ID is not conneted or Can't found")
                        initialViewController = LoginViewController() // or any other login view controller
                    @unknown default:
                        initialViewController = LoginViewController() // or any other login view controller
                    }
                    self.window?.rootViewController = initialViewController
                }
            }
        } else {
            // No user ID found in keychain, show the login screen by default
            let initialViewController = LoginViewController()
            self.window?.rootViewController = initialViewController
        }
        
        NotificationCenter.default.addObserver(forName: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil, queue: nil) { (Notification) in
            let initialViewController = LoginViewController()
            self.window?.rootViewController = initialViewController
        }
        
        if #available(iOS 13.0, *) {
            if let appearance = UserDefaults.standard.string(forKey: "Appearance") {
                if appearance == "Light" {
                    self.window?.overrideUserInterfaceStyle = .light
                } else {
                    self.window?.overrideUserInterfaceStyle = .dark
                }
            }
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

