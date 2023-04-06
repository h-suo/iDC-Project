//
//  SettingViewModel.swift
//  iDC_Project_basic
//
//  Created by 표현수 on 2023/03/21.
//

import UIKit

class SettingViewModel {
    
    var sections: [[String]] = []
    var sectionTitles: [String] = []
    
    init() {
        sections = [
            ["Light", "Dark"],
//            ["Notifications", "Sounds"],
            ["Withdraw"]
        ]
        sectionTitles = [
            "Theme Settings",
//            "Notification Settings",
            "Account Settings"
        ]
    }
}

// MARK: - Input
extension SettingViewModel {
    
    func lightThemeSelected() {
        UserDefaults.standard.set("Light", forKey: "Appearance")
    }
    
    func darkThemeSelected() {
        UserDefaults.standard.set("Dark", forKey: "Appearance")
    }
    
    func notificationON() {
        
    }
    
    func notificationOFF() {
        
    }
    
    func logOut() {
        
    }
    
    func withdraw() {
        
    }
}

// MARK: - Output
extension SettingViewModel {
    
    var numberOfSections: Int {
        return sections.count
    }
    
    var themeSettingSection: Int {
        return sectionTitles.firstIndex(of: "Theme Settings")!
    }
    
//    var notificationSettingSection: Int {
//        return sectionTitles.firstIndex(of: "Notification Settings")!
//    }
    
    var accountSettingSection: Int {
        return sectionTitles.firstIndex(of: "Account Settings")!
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func settingNumberOfRowInSection(_ section: Int) -> Int {
        return sections[section].count
    }
    
}


