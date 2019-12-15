//
//  SearchModel.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 15.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchModel {
    
    var totalCount: Int?
    var incompleteResults: Bool?
    var items: [RepoDetailModel]?
    
    class func parseSearchResult(from json: JSON)-> SearchModel {
        let search = SearchModel()
        search.totalCount = json["total_count"].int
        search.incompleteResults = json["incomplete_result"].bool
        
        let items = json["items"].array
        var parsedItems = [RepoDetailModel]()
        items?.forEach({ (item) in
            let parsedItem = RepoDetailModel.parseRepoDetailModel(from: item)
            parsedItems.append(parsedItem)
        })
        search.items = parsedItems
        
        return search
    }
    
}
