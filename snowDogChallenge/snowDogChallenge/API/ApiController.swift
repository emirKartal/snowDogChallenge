//
//  ApiController.swift
//  snowDogChallenge
//
//  Created by Emir Kartal on 12.12.2019.
//  Copyright © 2019 emir. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiController {
    
    class func performRequest(url: String = API_URL,endPoint: EndPoint, parameters: [String:Any]?, method: HTTPMethod = .get, encoding: ParameterEncoding = URLEncoding(destination: .queryString), completion: @escaping (_ response: APIResult<JSON, APIError>)->()) {

        let manager = Alamofire.SessionManager.default
        
        manager.request(url+endPoint.rawValue, method: method, parameters: parameters, encoding: encoding, headers: getHeader()).responseJSON { (response: DataResponse) in
            
            let json = JSON(response.result.value as Any)
            
            if response.result.isSuccess {
                completion(.success(json))
            } else {
                completion(.failure(APIError(type: .general)))
            }
        }
    }
    
    class func getHeader() -> HTTPHeaders {
        if let accessToken = User.currentUser.accessToken {
            return  ["Authorization":"token \(accessToken)"]
        } else {
            return ["Accept":"application/json"]
        }
        
    }
}

struct APIError: LocalizedError {
    public let type: ErrorMessage
    public var message: String = ""
    
    public enum ErrorMessage: String {
        case apiMessage = ""
        case general = "Something went wrong"
    }
    
    init(type: ErrorMessage, message: String = "") {
        self.type = type
        self.message = message
        if message == "" {
            self.message = self.type.rawValue
        }
    }
}

public enum APIResult<Value,APIError> {
    case success(Value)
    case failure(APIError)
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: APIError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

enum EndPoint: String {
    case accessTokenEndPoint = "login/oauth/access_token"
    case userEndPoint = "user"
}
