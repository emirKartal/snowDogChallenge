//
//  MainViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var splashView: UIView!
    
    var mainTabBarController = UITabBarController()
    
    override func awakeFromNib() {
        
        mainTabBarController = UIStoryboard(storyboard: .main).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        
        self.view.bringSubviewToFront(splashView)
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        User.getUserFromKeychain()
       
        if User.currentUser.hasToken {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.window?.rootViewController = self.mainTabBarController
                    appDelegate.window?.makeKeyAndVisible()
                }
            }
            
        } else {
            let loginVC: LoginViewController = UIStoryboard(storyboard: .main).create()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false) {
                self.view.sendSubviewToBack(self.splashView)
            }
        }
        
        if UserDefaults.standard.bool(forKey: showWalkthrough) == false {
            let walkthroughVC: WalkthroughViewController = UIStoryboard(storyboard: .walkthrough).create()
            walkthroughVC.modalPresentationStyle = .fullScreen
            self.presentedViewController?.present(walkthroughVC, animated: false, completion: {
                self.view.sendSubviewToBack(self.splashView)
            })
        }
    }

}
