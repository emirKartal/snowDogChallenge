//
//  UserModel.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 12.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import UIKit
import SwiftyJSON
import Valet

private let identifierUserKeychain = "snowDogUserData"

private enum Keys: String {
    case tokenType = "token_type"
    case accessToken = "access_token"
}

class User {
    
    static let currentUser = User()
    
    var tokenType: String?
    var accessToken: String? {
        didSet {
            if accessToken != nil {
                hasToken = true
            } else {
                hasToken = false
            }
        }
    }
    
    var hasToken = false
    
    //Parsing method userData
    class func saveToken(response: JSON) {
        currentUser.tokenType = response[Keys.tokenType.rawValue].string
        currentUser.accessToken = response[Keys.accessToken.rawValue].string
        
        saveUserDataToKeychain()
    }
    
    //MARK: Valet
    
    private let myValet = Valet.valet(with: Identifier(nonEmpty: identifierUserKeychain)!, accessibility: .always)
    
    private class func saveUserDataToKeychain() {
        if let accessToken = User.currentUser.accessToken, !accessToken.isEmpty {
            currentUser.myValet.set(string: accessToken, forKey: Keys.accessToken.rawValue)
        }
        if let tokenType = User.currentUser.tokenType, !tokenType.isEmpty {
            currentUser.myValet.set(string: tokenType, forKey: Keys.tokenType.rawValue)
        }
    }
    
    class func getUserFromKeychain() {
        
        currentUser.accessToken = currentUser.myValet.string(forKey: Keys.accessToken.rawValue)
        currentUser.tokenType = currentUser.myValet.string(forKey: Keys.tokenType.rawValue)
        
    }
    
    class func removeUserAllData() {
        currentUser.myValet.removeAllObjects()
        currentUser.accessToken = nil
        currentUser.tokenType = nil
        
    }
}
