//
//  TabbarVC.swift
//  Undefined
//
//  Created by pandora on 2020/08/30.
//  Copyright © 2020 Undefined. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UITabBar.appearance().barTintColor = .lightishPurple
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)

        let mainVC = UINavigationController(rootViewController: MainVC())
        let mainTabItem = UITabBarItem(title: "",
                                       image: UIImage(named: "homeicon"),
                                       tag: 0)
        mainVC.tabBarItem = mainTabItem
        
        let searchVC = SearchVC()
        let searchTabItem = UITabBarItem(title: "",
                                        image: UIImage(named: "searchicon"),
                                        tag: 1)
        searchVC.tabBarItem = searchTabItem
        
        let listVC = UINavigationController(rootViewController: ListVC())
        let listTabItem = UITabBarItem(title: "",
                                        image: UIImage(named: "hearticon"),
                                        tag: 2)
        listVC.tabBarItem = listTabItem
        
        let profileVC = UINavigationController(rootViewController: ProfileVC())
        let profileTabItem = UITabBarItem(title: "",
                                        image: UIImage(named: "profileicon"),
                                        tag: 3)
        profileVC.tabBarItem = profileTabItem

        self.viewControllers = [mainVC, searchVC, listVC, profileVC]
    }
    
}

extension TabbarVC : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("selected VC : \(viewController)")
        if viewController is SearchVC {
            let searchViewController = UINavigationController(rootViewController: SearchVC())
            searchViewController.modalPresentationStyle = .fullScreen
            self.present(searchViewController, animated: true)
            return false
        }
        return true
    }
}
