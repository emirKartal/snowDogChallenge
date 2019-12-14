//
//  Spinner.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import UIKit

class Spinner {
    
    static var spinner: UIActivityIndicatorView?
    
    class func start(frame: CGRect = UIScreen.main.bounds) {
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = frame
            spinner = UIActivityIndicatorView(frame: frame)
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    class func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
}
