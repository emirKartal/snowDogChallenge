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
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        
        self.setViewControllers([feedNavigationController,searchNavigationController], animated: false)
        
    }
    

}
