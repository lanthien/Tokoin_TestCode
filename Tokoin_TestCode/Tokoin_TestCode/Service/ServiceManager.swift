//
//  ServiceManager.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation

class ServiceManager: BaseServices {
    func getHeadlines(pageSize: UInt,
                      page: UInt,
                      _ completionHandler: (([New]) -> Void)?) {
        self.getNews(domain: .topHeadline,
                     pageSize: pageSize,
                     page: page,
                     completionHandler)
    }
    
    func getBitcoinNews(pageSize: UInt,
                        page: UInt,
                        _ completionHandler: (([New]) -> Void)?) {
        self.getNews(domain: .bitcoin,
                     pageSize: pageSize,
                     page: page,
                     completionHandler)
    }
    
    
    private func getNews(domain: URL_DOMAINS,
                         pageSize: UInt,
                         page: UInt,
                         _ completionHandler: (([New]) -> Void)?) {
        let url = domain.fullPath()
        var params: [String: Any] = ["page": Int(page)]
        if pageSize > 0 {
            params["pageSize"] = Int(pageSize)
        }
        
        self.get(urlStr: url, params: params) { (data, error) in
            guard let data = data
                else {
                    completionHandler?([])
                    return
            }
            
            guard let json = data as? String,
                let jsonData = json.data(using: .utf8)
                else {
                    completionHandler?([])
                    return
            }
            let decoder = JSONDecoder()
            do {
                let news = try decoder.decode([New].self, from: jsonData)
                completionHandler?(news)
            } catch {
                completionHandler?([])
            }
        }
    }
}
