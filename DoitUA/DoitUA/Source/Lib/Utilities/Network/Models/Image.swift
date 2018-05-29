//
//  Image.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

struct Image {
    let id: Int
    let imageURL: URL
    let description: String?
    let address: String?
    let hashtag: String?
    let latitude: Double
    let longitude: Double
    let weather: String?
    
    
    static func image(with json: [String: AnyObject]?) -> Image? {
        let keys = APIConfiguration.Image.self
        guard let json = json,
            let id = json[keys.id] as? Int,
            let imagePath = json[keys.imagePath] as? String,
            let imageURL = URL(string: imagePath),
            let parameters = json[keys.parameters] as? [String: AnyObject],
            let latitude = parameters[keys.latitude] as? Double,
            let longitude = parameters[keys.longitude] as? Double else {
                return nil
        }
        
        return Image(id: id,
                     imageURL: imageURL,
                     description: json[keys.description] as? String,
                     address: parameters[keys.address] as? String,
                     hashtag: json[keys.hashtag] as? String,
                     latitude: latitude,
                     longitude: longitude,
                     weather: parameters[keys.weather] as? String)
    }
}
