//
//  ImageSelector.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol ImageSelector: UINavigationControllerDelegate, UIImagePickerControllerDelegate {    
}

extension ImageSelector where Self: UIViewController {
    
    func showPicker(with title: String) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
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
    
    private func showImagePicker(with sourceType: UIImagePickerControllerSourceType) {
        let controller = UIImagePickerController()
        controller.allowsEditing = false
        controller.delegate = self
        controller.mediaTypes = [kUTTypeImage as String]
        controller.sourceType = sourceType
        self.present(controller, animated: true, completion: nil)
    }
    
}
