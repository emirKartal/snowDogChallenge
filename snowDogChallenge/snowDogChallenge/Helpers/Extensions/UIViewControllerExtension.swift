//
//  UIViewControllerExtension.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: ControllerMainFunctions  {
    
    //This func prevent writing same codes for setting up ui again
    @objc func setUIElements(title: String?, viewDelegation: [UIView]?) {
        self.navigationItem.title = title
        addLogoutButton()
        
        viewDelegation?.forEach({ (view) in
            if let collectionView = view as? UICollectionView {
                collectionView.delegate = self as? UICollectionViewDelegate
                collectionView.dataSource = self as? UICollectionViewDataSource
            } else if let tableView = view as? UITableView {
                tableView.delegate = self as? UITableViewDelegate
                tableView.dataSource = self as? UITableViewDataSource
                tableView.tableFooterView = UIView()
            } else if let searchBar = view as? UISearchBar {
                searchBar.delegate = self as? UISearchBarDelegate
            }
        })
    }
    
    func addLogoutButton() {
        let logoutButton = UIBarButtonItem(image: UIImage(named: "sd_logout"), style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logout() {
        User.removeUserAllData()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let mainVC: MainViewController = UIStoryboard(storyboard: .main).create()
            appDelegate.window?.rootViewController = mainVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
}
