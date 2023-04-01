//
//  TabBarController.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/09.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItem()
        
        self.delegate = self
    }
    
    // MARK: - Setup TapBar
    
    func setupTabBarItem() {
        
        let firstVC = UINavigationController(rootViewController: ViewController(postListViewModel: PostListViewModel()))
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        firstVC.tabBarItem.title = "home"
        /*
        let secondVC = UINavigationController(rootViewController: SearchViewController(postListViewModel: PostListViewModel()))
        secondVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        secondVC.tabBarItem.title = "search"
        
        
        let thirdVC = UINavigationController(rootViewController: AlarmViewController())
        thirdVC.tabBarItem.image = UIImage(systemName: "bell")
        thirdVC.tabBarItem.title = "alarm"
        */
        
        let forthVC = UINavigationController(rootViewController: SettingViewController(style: .insetGrouped, settingViewModel: SettingViewModel()))
        forthVC.tabBarItem.image = UIImage(systemName: "gearshape")
        forthVC.tabBarItem.title = "setting"
        
        viewControllers = [firstVC, forthVC]
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "home" {
            NotificationCenter.default.post(name: NSNotification.Name("homeTabBarTappedNotification"), object: nil)
        }
    }
}
