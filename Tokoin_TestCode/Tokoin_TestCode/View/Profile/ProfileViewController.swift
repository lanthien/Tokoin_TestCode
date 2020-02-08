//
//  ProfileViewController.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet internal weak var imvAvatar: UIImageView!
    @IBOutlet internal weak var lblName: UILabel!
    @IBOutlet internal weak var lblEmail: UILabel!
    @IBOutlet internal weak var tfPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func tapOnSignOutButton(_ sender: UIButton?) {
        UserDefaults.standard.removeObject(forKey: ACTIVED_USER_KEY)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
}
