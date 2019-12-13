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
        
        NotificationCenter.default.addObserver(self, selector: #selector(getUserDataWithToken), name: .notifyUserDataFunc, object: nil)
        
    }

    @IBAction func loginAction(_ sender: Any) {
        let authPath:String = "https://github.com/login/oauth/authorize?client_id=\(CLIENT_ID)"
        if let authURL:URL = URL(string: authPath)
        {
            UIApplication.shared.open(authURL)
        }
        
    }
    
    @objc func getUserDataWithToken() {
        getUserData()
    }
    
    private func getUserData() {
        AuthenticationApiController.getUserData { (result) in
            switch result {
            case .success(_):
                self.dismiss(animated: true, completion: nil)
                break
            case .failure(let error):
                break
            }
        }
    }
    
}

