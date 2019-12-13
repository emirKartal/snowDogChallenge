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
    case userId = "id"
    case userName = "login"
    case userImage = "avatar_url"
    case createdAt = "created_at"
    case followingsCount = "following"
    case followersCount = "followers"
    case publicReposCount = "public_repos"
    case receivedEventsUrl = "received_events_url"
}

class User {
    
    static let currentUser = User()
    
    //MARK: User auth data
    var hasToken = false
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
    
    //MARK: User profile data
    var userId: Int?
    var userName: String?
    var userImage: String?
    var createdAt: String?
    var followingsCount: Int?
    var followersCount: Int?
    var publicReposCount: Int?
    var receivedEventsUrl: String?
    var receivedEventsEndPoint: String? {
        get {
            let charCount = API_URL.count
            return String(self.receivedEventsUrl?.suffix((self.receivedEventsUrl?.count ?? charCount) - charCount) ?? "")
        }
    }
    
    //Parsing method userData
    class func saveToken(response: JSON) {
        currentUser.tokenType = response[Keys.tokenType.rawValue].string
        currentUser.accessToken = response[Keys.accessToken.rawValue].string
        
        saveUserDataToKeychain()
    }
    
    class func parseAndSaveUserData(json: JSON ) {
        currentUser.userId = json[Keys.userId.rawValue].int
        currentUser.userName = json[Keys.userName.rawValue].string
        currentUser.userImage = json [Keys.userImage.rawValue].string
        currentUser.createdAt = json[Keys.createdAt.rawValue].string
        currentUser.followingsCount = json[Keys.followingsCount.rawValue].int
        currentUser.followersCount = json[Keys.followersCount.rawValue].int
        currentUser.publicReposCount = json[Keys.publicReposCount.rawValue].int
        currentUser.receivedEventsUrl = json[Keys.receivedEventsUrl.rawValue].string
        
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
        if let userId = User.currentUser.userId {
            currentUser.myValet.set(string: "\(userId)", forKey: Keys.userId.rawValue)
        }
        if let userName = User.currentUser.userName, !userName.isEmpty {
            currentUser.myValet.set(string: userName, forKey: Keys.userName.rawValue)
        }
        if let userImage = User.currentUser.userImage, !userImage.isEmpty {
            currentUser.myValet.set(string: userImage, forKey: Keys.userImage.rawValue)
        }
        if let createdAt = User.currentUser.createdAt, !createdAt.isEmpty {
            currentUser.myValet.set(string: createdAt, forKey: Keys.createdAt.rawValue)
        }
        if let followingsCount = User.currentUser.followingsCount {
            currentUser.myValet.set(string: "\(followingsCount)", forKey: Keys.followingsCount.rawValue)
        }
        if let followersCount = User.currentUser.followersCount {
            currentUser.myValet.set(string: "\(followersCount)", forKey: Keys.followersCount.rawValue)
        }
        if let publicReposCount = User.currentUser.publicReposCount {
            currentUser.myValet.set(string: "\(publicReposCount)", forKey: Keys.publicReposCount.rawValue)
        }
        if let receivedEventsUrl = User.currentUser.receivedEventsUrl, !receivedEventsUrl.isEmpty {
            currentUser.myValet.set(string: receivedEventsUrl, forKey: Keys.receivedEventsUrl.rawValue)
        }
        
    }
    
    class func getUserFromKeychain() {
        
        currentUser.accessToken = currentUser.myValet.string(forKey: Keys.accessToken.rawValue)
        currentUser.tokenType = currentUser.myValet.string(forKey: Keys.tokenType.rawValue)
        currentUser.userId = Int(currentUser.myValet.string(forKey: Keys.userId.rawValue) ?? "")
        currentUser.userName = currentUser.myValet.string(forKey: Keys.userName.rawValue)
        currentUser.userImage = currentUser.myValet.string(forKey: Keys.userImage.rawValue)
        currentUser.createdAt = currentUser.myValet.string(forKey: Keys.createdAt.rawValue)
        currentUser.followingsCount = Int(currentUser.myValet.string(forKey: Keys.followingsCount.rawValue) ?? "")
        currentUser.followersCount = Int(currentUser.myValet.string(forKey: Keys.followersCount.rawValue) ?? "")
        currentUser.publicReposCount = Int(currentUser.myValet.string(forKey: Keys.publicReposCount.rawValue) ?? "")
        currentUser.receivedEventsUrl = currentUser.myValet.string(forKey: Keys.receivedEventsUrl.rawValue)
        
        
    }
    
    class func removeUserAllData() {
        currentUser.myValet.removeAllObjects()
        currentUser.accessToken = nil
        currentUser.tokenType = nil
        currentUser.userId = nil
        currentUser.userName = nil
        currentUser.userImage = nil
        currentUser.createdAt = nil
        currentUser.followingsCount = nil
        currentUser.followersCount = nil
        currentUser.publicReposCount = nil
        currentUser.receivedEventsUrl = nil

    }
}

