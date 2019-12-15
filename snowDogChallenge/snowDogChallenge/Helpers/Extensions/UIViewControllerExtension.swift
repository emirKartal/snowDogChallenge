//
//  UIViewControllerExtension.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

extension UIViewController: ControllerMainFunctions  {
    
    func showBanner(title: String, subTitle: String, style: BannerStyle) {
        let banner = NotificationBanner(title: title, subtitle: subTitle, leftView: nil, rightView: nil, style: style, colors: nil)
        banner.show()
    }
    
    //This func prevent writing same codes for setting up ui again
    @objc func setUIElements(title: String?, viewDelegation: [UIView]?) {
        self.navigationItem.title = title
        addLogoutButtonAndHomeButton()
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
    
    func addLogoutButtonAndHomeButton() {
        
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageview = CachedImageClass(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageview.loadImageFromApi(urlString: User.currentUser.userImage ?? "")
        imageview.contentMode = UIView.ContentMode.scaleAspectFit
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = imageview.frame.width / 2
        containView.addSubview(imageview)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileButtonAction))
        containView.isUserInteractionEnabled = true
        containView.addGestureRecognizer(tapGesture)
    
        let logoutButton = UIBarButtonItem(image: UIImage(named: "sd_logout"), style: .plain, target: self, action: #selector(logout))
         let profileButton = UIBarButtonItem(customView: containView)
        self.navigationItem.rightBarButtonItems = [logoutButton,profileButton]
    }
    
    @objc func logout() {
        User.removeUserAllData()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let mainVC: MainViewController = UIStoryboard(storyboard: .main).create()
            appDelegate.window?.rootViewController = mainVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    @objc func profileButtonAction(){
        print("homeAction")
    }
    
}
