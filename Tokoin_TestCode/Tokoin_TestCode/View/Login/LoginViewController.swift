//
//  LoginViewController.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet internal weak var tfEmail: SimpleFloatTextField!
    @IBOutlet internal weak var tfPassword: SimpleFloatTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction internal func tapOnLoginBtn(_ sender: UIButton?) {
        guard checkIsValid() else { return }
        guard let user = self.getUser()
            else {
                self.showSimpleAlert(title: "Error",
                                     message: "Can not found this User.")
                return
        }
        
        if let pass = self.tfPassword.text?.data(using: .utf8)?.base64EncodedString(),
            pass != user.password {
            self.showSimpleAlert(title: "Error",
                                 message: "Email or password is wrong.")
            return
        }
        
        UserDefaults.standard.set(user.email, forKey: ACTIVED_USER_KEY)
        
        let tabbarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabbarViewController")
        self.view.window?.rootViewController = tabbarVC
        self.view.window?.makeKeyAndVisible()
        
    }
    
    internal func checkIsValid() -> Bool {
        if self.tfEmail.text == nil ||
            (self.tfEmail.text?.count ?? 0) == 0 {
            self.showSimpleAlert(title: "Warning", message: "Email is empty.")
            return false
        }
        if !(self.tfEmail.text?.isEmail ?? false) {
            self.showSimpleAlert(title: "Warning", message: "Email is invalid")
            return false
        }
        if self.tfPassword.text == nil ||
            (self.tfPassword.text?.count ?? 0) == 0 {
            self.showSimpleAlert(title: "Warning", message: "Password is empty.")
            return false
        }
        if (self.tfPassword.text?.count ?? 0) < 3 {
            self.showSimpleAlert(title: "Warning", message: "Password is invalid.")
            return false
        }
        return true
    }
    
    internal func getUser() -> User? {
        guard let email = self.tfEmail.text else { return nil }
        let user: User? = RealmDBManager.shareInstance.getDataFromDB(primaryKey: email)
        return user
        
    }
}
