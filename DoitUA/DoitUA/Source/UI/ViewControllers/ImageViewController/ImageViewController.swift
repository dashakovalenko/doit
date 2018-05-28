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
    
    var session: Session?

    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Actions
    
    @IBAction func didChangeDescription(_ sender: UITextField) {
    }
    
    @IBAction func didChangeHashtags(_ sender: UITextField) {
    }
    
    @IBAction func didTapOnImage(_ sender: Any) {
    }
    
    @IBAction func didClickOnSend(_ sender: Any) {
    }
    
}


