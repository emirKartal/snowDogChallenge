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
    
    
    
}
