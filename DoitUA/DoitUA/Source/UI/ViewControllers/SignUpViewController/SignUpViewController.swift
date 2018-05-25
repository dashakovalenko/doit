//
//  SignUpViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/23/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import MobileCoreServices

class SignUpViewController: ViewController, ImageSelector {
    
    private let signupModel = SignUpViewModel()
    
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var avatarImageView: UIImageView!
    
    //MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Private methods
    
    @IBAction func didClickOnAvatar(_ sender: Any) {
        showPicker(with: "Select avatar photo")
    }
    
    @IBAction func didChangeEmail(_ sender: UITextField) {
        signupModel.email = sender.text
    }
    
    @IBAction func didChangePassword(_ sender: UITextField) {
        signupModel.password = sender.text
    }
    
    @IBAction func didChangeUsername(_ sender: UITextField) {
        signupModel.username = sender.text
    }
    
    @IBAction func didClickOnSend(_ sender: Any) {
        signupModel.loadData { [weak self] result in
            print(result)
            switch result {
            case .success(let response):
                print(String(describing: response))
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: false, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            signupModel.avatar = image
            avatarImageView.image = image
        }
    }

}
