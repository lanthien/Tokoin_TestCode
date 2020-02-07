//
//  String+Extension.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation

extension String {
    var isEmail: Bool {
        let pattern = "^[a-z][a-z0-9_\\.]{5,32}@[a-z0-9]{2,}(\\.[a-z0-9]{2,4}){1,2}$"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            else { return false }
        let results = regex.matches(in: self,
                                   options: .init(rawValue: 0),
                                   range: NSRange(location: 0, length: self.count))
        return results.count == 1
    }
    
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        return dateFormatter.date(from: self) ?? Date()
    }
}
