//
//  ViewController+Extension.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String?, message msg: String?, _ completion:(() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (_) in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
