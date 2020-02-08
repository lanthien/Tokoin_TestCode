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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configUI()
    }
    
    private func configUI() {
        self.imvAvatar.roundView(.black)
        
        guard let user = LoginManager.instance.user
            else { return}
        self.lblName.text = user.name
        self.lblEmail.text = user.email
        if let imageData = user.avatar {
            self.imvAvatar.image = UIImage(data: imageData)
        }
    }
    
    @IBAction private func tapOnSignOutButton(_ sender: UIButton?) {
        LoginManager.instance.signOut()
    }
}
