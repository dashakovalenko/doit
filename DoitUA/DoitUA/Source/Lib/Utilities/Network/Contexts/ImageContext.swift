//
//  ImageContext.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ImageContext: NetworkContext<[String: AnyObject]> {
    let image: UIImage
    let description: String?
    let hashtag: String?
    let latitude: Double
    let longitude: Double
    let session: Session?
    
    init(session: Session?, image: UIImage, description: String?, hashtag: String?, latitude: Double, longitude: Double) {
        self.session = session
        self.image = image
        self.description = description
        self.hashtag = hashtag
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override func execute(_ completion: ((Result<[String: AnyObject]>) -> (Void))?) -> Self {
        let keys = APIConfiguration.Image.self
        var parameters = [keys.latitude: String(latitude), keys.longitude: String(longitude)]
        parameters[keys.description] = description
        parameters[keys.hashtag] = hashtag
        
        networkRequest.sendMultpartRequest(with: APIConfiguration.Paths.image,
                                           parameters: parameters,
                                           image: image,
                                           imageKey: keys.image,
                                           token: session?.token,
                                           successHandler: { $0 },
                                           completion: completion)
        
        return self
    }
}
