//
//  RegisterViewController.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/7/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit

class RegisterViewController: LoginViewController, UINavigationControllerDelegate {
    @IBOutlet private weak var imvAvatar: UIImageView!
    @IBOutlet private weak var tfName: SimpleFloatTextField!
    @IBOutlet private weak var tfConfirmPassword: SimpleFloatTextField!
    @IBOutlet private weak var vwAvatar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.vwAvatar.roundView()
    }
    
    @IBAction private func tapOnRegisterBtn(_ sender: UIButton?) {
        guard checkIsValid()
            else { return }
        LoginManager.instance
            .signup(name: self.tfName.text!,
                    email: self.tfEmail.text!,
                    password: self.tfPassword.text!,
                    avatar: self.imvAvatar.image)
    }
    
    @IBAction private func tapOnCloseBtn(_ sender: UIButton?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapOnEditButton(_ sender: UIButton?) {
        let alert = UIAlertController(title: "Choose photo from:", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self](_) in
            self?.showPickerView(type: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [weak self](_) in
            self?.showPickerView(type: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    internal override func checkIsValid() -> Bool {
        guard super.checkIsValid() else { return false }
        
        if self.tfName.text == nil || (self.tfName.text?.count ?? 0) == 0 {
            self.showSimpleAlert(title: "Warning", message: "Your name is empty")
            return false
        }
        
        if let text = self.tfName.text,
            text.count < 3 {
            self.showSimpleAlert(title: "Warning",
                                 message: "Your name much have at least 3 characters.")
            return false
        }
        
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
    
    private func showPickerView(type: UIImagePickerController.SourceType) {
        if !UIImagePickerController.isSourceTypeAvailable(type) {
            self.showSimpleAlert(title: "Error", message: "Your choosed option is not available. Please try again.")
            return
        }
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        imagePickerView.sourceType = type
        imagePickerView.allowsEditing = true
        self.present(imagePickerView, animated: true, completion: nil)
    }
}

//MARK: - UIPickerViewDelegate
extension RegisterViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.imvAvatar.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
