//
//  WalkthroughViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: showWalkthrough)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
