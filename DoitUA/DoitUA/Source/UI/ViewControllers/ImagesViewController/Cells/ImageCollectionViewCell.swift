//
//  ImageCollectionViewCell.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/28/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    func setup(with image: Image) {
        iconView.kf.setImage(with: image.imageURL)
        weatherLabel.text = image.weather
        addressLabel.text = image.address ?? "The address is not available in this place"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.kf.cancelDownloadTask()
    }
}
