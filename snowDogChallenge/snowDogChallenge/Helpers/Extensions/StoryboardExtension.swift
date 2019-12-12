//
//  StoryboardExtension.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardIdentiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    enum StoryboardName: String {
        case main
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: StoryboardName, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    class func storyboard(_ storyboard: StoryboardName, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    func create<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Error \(T.storyboardIdentifier)")
        }
        return viewController
    }
    
}
extension UIViewController: StoryboardIdentiable { }
