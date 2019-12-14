//
//  CachedImageClass.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class CachedImageClass: UIImageView {
    
    var imageURLString: String?
    
    func loadImageFromApi(urlString: String) {
        
        imageURLString = urlString
        self.image = nil  //In order to prevent reusable cell problems
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        Alamofire.request(urlString).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                    let imageToCache = UIImage(data: data)
                    
                    if self.imageURLString == urlString {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                }
            }
        }
    }
    
}
