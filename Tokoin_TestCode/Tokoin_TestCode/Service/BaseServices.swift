//
//  BaseServices.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let BASE_URL: String = "https://newsapi.org/v2/"

enum URL_DOMAINS: String {
    case topHeadline = "top-headlines"
    case bitcoin = "bitcoin"
    
    func fullPath() -> String {
        if self == .topHeadline {
            return BASE_URL + self.rawValue + "?country=us&"
        }
        return BASE_URL + "everything?q=\(self.rawValue)&"
    }
}

class BaseServices {
    fileprivate let API_KEY = "81375c9e8f9f4e2693db6e31d660668a"
    
    func get(urlStr: String,
             params: [String: Any]? = nil,
             header: HTTPHeaders? = nil,
             completion: ((Any?, Error?) -> Void)?) {
        let url = urlStr + "&apiKey=\(API_KEY)"
        
        Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: header)
            .responseJSON { (dataResponse) in
                if let error = dataResponse.error {
                    completion?(nil, error)
                } else {
                    completion?(dataResponse.value, nil)
                }
        }
    }
}
