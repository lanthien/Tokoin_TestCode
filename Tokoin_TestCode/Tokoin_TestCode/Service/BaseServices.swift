//
//  BaseServices.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let BASE_URL: String = "https://newsapi.org/v2/%@"

enum URL_DOMAINS: String {
    case topHeadline = "top-headlines"
    case bitcoin = "bitcoin"
    
    func fullPath() -> String {
        return BASE_URL + self.rawValue
    }
}

class BaseServices {
    fileprivate let API_KEY = "0417fa47e82c4a0abdea882e327964d8"
    
    func get(urlStr: String,
             params: [String: Any]? = nil,
             header: HTTPHeaders? = nil,
             completion: ((Any?, Error?) -> Void)?) {
        var requestParams: [String: Any]
        if let params = params {
            requestParams = params
        } else {
            requestParams = [String: Any]()
        }
        requestParams["country"] = "us"
        requestParams["apiKey"] = "API_KEY"
        
        Alamofire.request(urlStr, method: .get, parameters: params, encoding: JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                if let error = dataResponse.error {
                    completion?(nil, error)
                } else {
                    completion?(dataResponse.value, nil)
                }
        }
    }
}
