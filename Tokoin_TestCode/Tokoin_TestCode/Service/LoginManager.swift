//
//  Constants.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import Foundation
import UIKit

let ACTIVED_USER_KEY = "ACTIVED_USER"

class LoginManager {
    private var activedUser: User?
    static let instance = LoginManager()
    
    private init() {
        guard let email: String = UserDefaults.standard.string(forKey: ACTIVED_USER_KEY),
            let user: User = RealmDBManager.shareInstance.getDataFromDB(primaryKey: email)
            else { return }
        self.activedUser = user

    }
    
    func signOut() {
        UserDefaults.standard.removeObject(forKey: ACTIVED_USER_KEY)
        self.activedUser = nil
        self.moveToViewController(id: "LoginViewController")
    }
    
    func signIn(user: User) {
        self.activedUser = user
        UserDefaults.standard.set(user.email, forKey: ACTIVED_USER_KEY)
        self.moveToViewController(id: "MainTabbarViewController")
    }
    
    func signup(name: String,
                email: String,
                password: String,
                avatar: UIImage? = nil) {
        let user = User()
        user.name = name
        user.email = email
        if let pass = password.data(using: .utf8)?.base64EncodedString() {
            user.password = pass
        }
        if let data = avatar?.jpegData(compressionQuality: 0) {
            user.avatar = data
        } else {
            user.avatar = avatar?.pngData()
        }
        self.activedUser = user
        RealmDBManager.shareInstance.addObject(user)
        UserDefaults.standard.set(email, forKey: ACTIVED_USER_KEY)
        self.moveToViewController(id: "MainTabbarViewController")
    }
    
    var user: User? {
        return self.activedUser
    }
    
    private func moveToViewController(id: String) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: id)
        let window = UIApplication.shared.windows.first
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
