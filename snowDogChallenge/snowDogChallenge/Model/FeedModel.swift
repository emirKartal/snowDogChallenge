//
//  FeedModel.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedModel {
    var id: String?
    var createdAt: String?
    var type: String?
    
    var repoName: String?
    var repoUrl: String?
    var repoDescription: String?
    
    var actorName: String?
    var actorImageUrl: String?
    var actorUrl: String?
    
    var repoEndPoint: String? {
        get {
            let charCount = API_URL.count
            return String(self.repoUrl?.suffix((self.repoUrl?.count ?? charCount) - charCount) ?? "")
        }
    }
    
    class func parseFeedModel(from json: JSON) -> FeedModel {
        let feed = FeedModel()
        feed.id = json["id"].string
        feed.createdAt = json["created_at"].string
        feed.type = json["type"].string
        
        feed.repoName = json["repo"]["name"].string
        feed.repoUrl = json["repo"]["url"].string
        feed.repoDescription = json["payload"]["description"].string
        
        feed.actorName = json["actor"]["login"].string
        feed.actorImageUrl = json["actor"]["avatar_url"].string
        feed.actorUrl = json["actor"]["url"].string
        
        return feed
    }
    
}
