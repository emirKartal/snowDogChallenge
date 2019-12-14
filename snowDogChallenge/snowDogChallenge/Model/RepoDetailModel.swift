//
//  RepoDetailModel.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 14.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import SwiftyJSON

class RepoDetailModel {
    var id: Int?
    var name: String?
    var fullName: String?
    var isPrivate: Bool?
    var createdAt: String?
    var updatedAt: String?
    var language: String?
    var starCount: Int?
    var watcherCount: Int?
    var forkCount: Int?
    var openIssuesCount: Int?
    var subscriberCount: Int?
    
    class func parseRepoDetailModel(from json: JSON)-> RepoDetailModel {
        let repoDetail = RepoDetailModel()
        repoDetail.id = json["id"].int
        repoDetail.name = json["name"].string
        repoDetail.fullName = json["full_name"].string
        repoDetail.isPrivate = json["private"].bool
        repoDetail.createdAt = json["created_at"].string
        repoDetail.updatedAt = json["updated_at"].string
        repoDetail.language = json["language"].string
        repoDetail.starCount = json["stargazers_count"].int
        repoDetail.watcherCount = json["watchers_count"].int
        repoDetail.forkCount = json["forks"].int
        repoDetail.openIssuesCount = json["open_issues_count"].int
        repoDetail.subscriberCount = json["subscribers_count"].int
        
        return repoDetail
    }
    
}
