//
//  FeedApiController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 13.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation

class FeedApiController: ApiController {
    
    class func getFeeds(completion: @escaping (_ result: APIResult<[FeedModel]?, APIError>)->()) {
        
        let feedUrl = User.currentUser.receivedEventsEndPoint!
        
        performRequest(endPoint: feedUrl, parameters: nil) { (result) in
            switch result {
            case .success(let json):
                let feedArray = json.array
                var parsedFeedArray = [FeedModel]()
                
                feedArray?.forEach({ (feed) in
                    let parsedFeed = FeedModel.parseFeedModel(from: feed)
                    parsedFeedArray.append(parsedFeed)
                })
                
                completion(.success(parsedFeedArray))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
            
        }
    }
    
    class func getRepoDetail(endPoint: String, completion: @escaping (_ result: APIResult<RepoDetailModel?, APIError>)->()) {
        
        performRequest(endPoint: endPoint, parameters: nil) { (result) in
            switch result {
            case .success(let json):
                let repoDetail = RepoDetailModel.parseRepoDetailModel(from: json)
                completion(.success(repoDetail))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        
    }
    
}
