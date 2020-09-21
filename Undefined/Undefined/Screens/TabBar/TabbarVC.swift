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
                
        let mainVC = UINavigationController(rootViewController: MainVC())
        let mainTabItem = UITabBarItem(title: "Main",
                                        image: nil,
                                        tag: 0)
        mainVC.tabBarItem = mainTabItem
        
        let searchVC = SearchVC()
        let searchTabItem = UITabBarItem(title: "Search",
                                        image: nil,
                                        tag: 1)
        searchVC.tabBarItem = searchTabItem
        
        let listVC = ListVC()
        let listTabItem = UITabBarItem(title: "List",
                                        image: nil,
                                        tag: 2)
        listVC.tabBarItem = listTabItem
        
        let profileVC = UINavigationController(rootViewController: ProfileVC())
        let profileTabItem = UITabBarItem(title: "Profile",
                                        image: nil,
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
