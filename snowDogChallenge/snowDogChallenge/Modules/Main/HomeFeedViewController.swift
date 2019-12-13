//
//  HomeFeedViewController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit

class HomeFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedApiController.getFeeds { (result) in
            switch result {
            case .success(let data):
                break
            case .failure(let error):
                break
            }
        }
    }

}
