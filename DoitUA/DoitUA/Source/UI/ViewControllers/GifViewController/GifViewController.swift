//
//  GifViewController.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class GifViewController: ViewController {

    @IBOutlet var gifImageView: UIImageView!
    
    var gifURL: String? = "http://api.doitserver.in.ua/upload/images/gif/939949db47915a6189700d842a5e7ed5.gif" {
        didSet {
            if isViewLoaded {
                updateGif()
            }
        }
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGif()
    }
    
    //MARK: - Actions
    
    @IBAction func onDismiss(_ sender: Any) {
        dismiss(animated: true)
    }
 
    //MARK: - Private
    
    private func updateGif() {
        gifURL.map { gifURL in
            DispatchQueue.global().async {
                let image = UIImage.gif(url: gifURL)
                DispatchQueue.main.async {
                    self.gifImageView.image = image
                }
            }
        }
    }
}
