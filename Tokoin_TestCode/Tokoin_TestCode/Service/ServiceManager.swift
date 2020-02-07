//
//  ServiceManager.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation

class ServiceManager: BaseServices {
    static let instance = ServiceManager()
    
    private override init() {}
    
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
        var url = domain.fullPath() + "?page=\(Int(page))"
        if pageSize > 0 {
            url.append(contentsOf: "&pageSize=\(Int(pageSize))")
        }
        
        self.get(urlStr: url, params: nil) { (data, error) in
            guard let data = data
                else {
                    completionHandler?([])
                    return
            }
            
            do {
                guard let json = data as? [String: Any],
                    let articles = json["articles"] as? [Any]
                    else {
                        completionHandler?([])
                        return
                }
                let jsonData = try JSONSerialization.data(withJSONObject: articles, options: .prettyPrinted)
                let decoder = JSONDecoder()
                let news = try decoder.decode([New].self, from: jsonData)
                completionHandler?(news)
            } catch {
                completionHandler?([])
            }
        }
    }
}
