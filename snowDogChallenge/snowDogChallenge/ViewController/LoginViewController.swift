//
//  ViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 11.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        User.getUserFromKeychain()
        
    }

    @IBAction func loginAction(_ sender: Any) {
        if User.currentUser.hasToken {
            
        } else {
            let authPath:String = "https://github.com/login/oauth/authorize?client_id=a8ae507ca4edd439f833"
            if let authURL:URL = URL(string: authPath)
            {
                UIApplication.shared.open(authURL)
            }
        }

    }
    
}

