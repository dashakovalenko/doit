//
//  ImageViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import Photos
import CoreLocation

class ImageViewController: ViewController, ImageSelector {

    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var hashtagsField: UITextField!
    @IBOutlet var iconView: UIImageView!
    
    var newImageHandler: (() -> ())?
    
    private let newImageModel = ImageViewModel()
    var session: Session? {
        get {
            return newImageModel.session
        }
        set {
            newImageModel.session = newValue
        }
    }
    
    private let locationManager = LocationManager()
    
    //MARK: - Init and deinit
    
    deinit {
        locationManager.stopUpdating()
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.startUpdating()
    }

    //MARK: - Actions
    
    @IBAction func didChangeDescription(_ sender: UITextField) {
        newImageModel.description = sender.text
    }
    
    @IBAction func didChangeHashtags(_ sender: UITextField) {
        newImageModel.hashtags = sender.text
    }
    
    @IBAction func didTapOnImage(_ sender: Any) {
        showPicker(with: "Select image")
    }
    
    @IBAction func didClickOnSend(_ sender: Any) {
        newImageModel.loadData { [weak self] (result) in
            switch result {
            case .success(let response):
                print(String(describing: response))
                self?.newImageHandler?()
                self?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
    
}

extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: false, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImageModel.image = image
            iconView.image = image
        
            let imageCoordinate = self.coodinates(with: info) ?? locationManager.currentCoodrinate
            newImageModel.latitude = imageCoordinate?.latitude
            newImageModel.longitude = imageCoordinate?.longitude
            print(String(describing: imageCoordinate))
        }
    }
    
    private func coodinates(with info: [String: Any]) -> CLLocationCoordinate2D? {
        if #available(iOS 11.0, *) {
            return (info[UIImagePickerControllerPHAsset] as? PHAsset)?.location?.coordinate
        } else {
            return (info[UIImagePickerControllerReferenceURL] as? URL).flatMap {
                PHAsset.fetchAssets(withALAssetURLs: [$0], options: nil).lastObject?.location?.coordinate
            }
        }
    }
}
