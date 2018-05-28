//
//  ImageViewModel.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class ImageViewModel {
    
    var session: Session?
    var image: UIImage?
    var description: String?
    var hashtags: String?
    var latitude: Double?
    var longitude: Double?
    
    var context: ImageContext?
    
}

extension ImageViewModel: ViewModel {
    
    typealias T = [String: AnyObject]
    
    func loadData(completion: ((Result<[String: AnyObject]>) -> ())?) {
        guard let image = image else {
            completion?(Result.failure(NSError.error(description: "You should select image")))
            return
        }
        
        context = ImageContext(session: session,
                               image: image,
                               description: description,
                               hashtag: hashtags,
                               latitude: latitude ?? 0,
                               longitude: longitude ?? 0)
            .execute(completion)
    }
    
}
