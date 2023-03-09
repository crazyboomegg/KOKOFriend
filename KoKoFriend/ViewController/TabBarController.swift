//
//  TabBarViewController.swift
//  KoKoFriend
//
//  Created by 江柏毅 on 2023/3/5.
//

import Foundation
import UIKit


//enum TabBarItemType {
//    case Money, Friend, Ok, KeepAccounts, Setting
//}

class TabBarController: UITabBarController {
//    var tabs: [TabBarItemType] = []
//    let defaultTab = TabBarItemType.Friend
    
    
    var currentVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // view.backgroundColor = UIColor.red
        self.tabBar.backgroundColor = UIColor(hexString: "efefef")
        let moneyVC = FriendListViewController()
        let friendVC = FriendListViewController()
        let okVC = FriendListViewController()
        let accountVC = FriendListViewController()
        let settingVC = FriendListViewController()
        
        moneyVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "KoKoiCon_Money"), selectedImage: nil)
        friendVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "KoKoiCon_Friend"), selectedImage: nil)
        okVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_home_off-1"), selectedImage: nil)
        accountVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_manage_off"), selectedImage: nil)
        settingVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_tabbar_setting_off"), selectedImage: nil)
       

        // 設定選中的 TabBarItem 圖示顏色
        UITabBar.appearance().tintColor = UIColor(hexString: "#ec008c")
        
        viewControllers = [moneyVC, friendVC, okVC, accountVC, settingVC]

        }

    }
    
    

    
    
    
    
    
    
    
    
    


