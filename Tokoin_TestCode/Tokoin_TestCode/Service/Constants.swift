//
//  Constants.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation

let ACTIVED_USER_KEY = "ACTIVED_USER"

class GlobalConstants {
    static let instance = GlobalConstants()
    private init() {}
}

class LoginManager {
    private var activedUser: User?
    static let instance = LoginManager()
    private init() {}
    
}
