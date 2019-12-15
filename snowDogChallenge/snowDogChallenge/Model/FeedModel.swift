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
    var createdAt: String? {
        didSet {
            //2019-12-13T12:30:08Z"
            createdAt = createdAt?.convertToDate(format: "yyyy-MM-dd'T'HH:mm:ss'Z')")?.convertToString(format:  "d MMM yy hh:mm")
        }
    }
    var type: String? {
        didSet {
            let enumType = FeedType(rawValue: type ?? "")
            type = enumType?.manuplate
        }
    }
    
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

enum FeedType: String {
    case createEvent = "CreateEvent"
    case forkEvent = "ForkEvent"
    
    var manuplate: String {
        switch self {
        case .createEvent:
            return "created"
        case .forkEvent:
            return "forked"
        }
    }
}
