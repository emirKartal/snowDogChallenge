//
//  TabBarController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var feedNavigationController: NavigationController!
    var searchNavigationController: NavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()

        feedNavigationController = UIStoryboard(storyboard: .main).instantiateViewController(withIdentifier: "FeedNavigation") as? NavigationController
        searchNavigationController = UIStoryboard(storyboard: .main).instantiateViewController(withIdentifier: "SearchNavigation") as? NavigationController
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "sd_home"), selectedImage: nil)
        searchNavigationController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "sd_search"), selectedImage: nil)
        
        self.setViewControllers([feedNavigationController,searchNavigationController], animated: false)
        
        var y: CGFloat = 12
        if UIApplication.shared.delegate?.window??.safeAreaInsets.bottom == 0 {
            y = 6
        }
        
        let array = self.customizableViewControllers
        array?.forEach({ (controller) in
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: y, left: 0, bottom: -y, right: 0)
        })
        
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tintColor = .black
        
        self.tabBar.isTranslucent = false
        
    }
    

}
