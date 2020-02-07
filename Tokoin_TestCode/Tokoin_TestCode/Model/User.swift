//
//  User.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    
    override static func primaryKey() -> String? {
        return "email"
    }
}
