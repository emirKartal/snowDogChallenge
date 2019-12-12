//
//  AuthenticationApiController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 12.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation

class AuthenticationApiController: ApiController {
    
    
    // Getting code from redirect URL
    class func getCode(from url: URL) {
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        var code:String?
        if let queryItems = components?.queryItems {
            for queryItem in queryItems {
                if (queryItem.name.lowercased() == "code") {
                    code = queryItem.value
                    if let receivedCode = code {
                        getAccessToken(with: receivedCode)
                    }
                }
            }
        }
    }
    
    // Getting access token with code that we get the function above
    class func getAccessToken(with code: String) {
        
        var parameters = [String: Any]()
        parameters["client_id"] = CLIENT_ID
        parameters["client_secret"] = CLIENT_SECRET
        parameters["code"] = code
        
        performRequest(endPoint: .accessTokenEndPoint, parameters: parameters) { (result) in
            switch result {
            case .success(let json):
                User.saveToken(response: json)
                break
            case .failure(let error):
                break
            }
        }
    }
    
    
}
