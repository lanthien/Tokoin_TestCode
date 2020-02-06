//
//  New.swift
//  Tokoin_TestCode
//
//  Created by LanThien on 2/6/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation

class New: Decodable {
    var source: [Source]
    var author: String?
    var title: String
    var description: String
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}
