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
        
        setupTabBar()
        setupTabBarItem()
    }
    
    // MARK: - Setup TapBar
    func setupTabBar() {
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    func setupTabBarItem() {
        
        let firstVC = UINavigationController(rootViewController: ViewController(postListViewModel: PostListViewModel()))
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        firstVC.tabBarItem.title = "home"
        
        
        let secondVC = UINavigationController(rootViewController: SearchViewController(postListViewModel: PostListViewModel()))
        secondVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        secondVC.tabBarItem.title = "search"
        
        /*
        let thirdVC = UINavigationController(rootViewController: AlarmViewController())
        thirdVC.tabBarItem.image = UIImage(systemName: "bell")
        thirdVC.tabBarItem.title = "alarm"
        */
        
        let forthVC = UINavigationController(rootViewController: SettingViewController())
        forthVC.tabBarItem.image = UIImage(systemName: "gearshape")
        forthVC.tabBarItem.title = "setting"
        
        viewControllers = [firstVC, secondVC, forthVC]
    }
}
