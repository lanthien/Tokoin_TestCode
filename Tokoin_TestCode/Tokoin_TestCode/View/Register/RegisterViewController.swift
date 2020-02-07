//
//  RegisterViewController.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

class RegisterViewController: LoginViewController {
//    @IBOutlet private weak var tfEmail: SimpleFloatTextField!
//    @IBOutlet private weak var tfPassword: SimpleFloatTextField!
    @IBOutlet private weak var tfConfirmPassword: SimpleFloatTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func tapOnRegisterBtn(_ sender: UIButton?) {
        guard checkIsValid(),
            createUserInfo()
            else { return }
        UserDefaults.standard.set(self.tfEmail.text!, forKey: ACTIVED_USER_KEY)
        let tabbarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabbarViewController")
        self.view.window?.rootViewController = tabbarVC
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction private func tapOnCloseBtn(_ sender: UIButton?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    internal override func checkIsValid() -> Bool {
        guard super.checkIsValid() else { return false }
        if let pass = self.tfPassword.text,
            let confirmPass = self.tfConfirmPassword.text,
            pass != confirmPass {
            self.showSimpleAlert(title: "Warning", message: "Password and confirm password are not match.")
            return false
        }
        if let _ = self.getUser() {
            self.showSimpleAlert(title: "Warning", message: "This email has been used.")
            return false
        }
        return true
    }
    
    private func createUserInfo() -> Bool {
        guard let email = self.tfEmail.text,
            let pass = self.tfPassword.text
            else { return false }
        let user = User()
        user.email = email
        user.password = pass.data(using: .utf8)?.base64EncodedString() ?? ""
        return RealmDBManager.shareInstance.addObject(user)
    }
}
