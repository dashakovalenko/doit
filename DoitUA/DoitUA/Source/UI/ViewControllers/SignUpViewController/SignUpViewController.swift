//
//  SignUpViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/23/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import MobileCoreServices

class SignUpViewController: ViewController {
    
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
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: "Select avatar photo",
                                                    message: nil,
                                                    preferredStyle: .actionSheet)
            [UIAlertAction(title: "Take photo", style: .default, handler: { _ in
                self.showImagePicker(with: .camera)
            }),
             UIAlertAction(title: "Select from Library", style: .default, handler: { _ in
                self.showImagePicker(with: .photoLibrary)
             }),
             UIAlertAction(title: "Cancel", style: .cancel)]
                .forEach(alertController.addAction)
            present(alertController, animated: true, completion: nil)
        } else {
            showImagePicker(with: .photoLibrary)
        }
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
    
    private func showImagePicker(with sourceType: UIImagePickerControllerSourceType) {
        let controller = UIImagePickerController()
        controller.allowsEditing = false
        controller.delegate = self
        controller.mediaTypes = [kUTTypeImage as String]
        controller.sourceType = sourceType
        self.present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: false, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            signupModel.avatar = image
            avatarImageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
