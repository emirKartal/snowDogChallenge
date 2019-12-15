//
//  SearchApiController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 15.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation

class SearchApiController: ApiController {
    
    class func getSearchResult(query: String, page: Int, completion: @escaping (_ result: APIResult<SearchModel?,APIError>)->()) {
        var parameters = [String: Any]()
        parameters["q"] = query
        parameters["page"] = page
        
        performRequest(endPoint: EndPoint.searchRepoEndPoint.rawValue , parameters: parameters) { (result) in
            switch result {
            case .success(let json):
                let searchResults = SearchModel.parseSearchResult(from: json)
                completion(.success(searchResults))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    
}

