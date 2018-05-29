//
//  GifViewModel.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class GifViewModel {
    var session: Session?
    var context: GifContext?
}

extension GifViewModel: ViewModel {
    typealias T = UIImage?
    
    func loadData(completion: ((Result<UIImage?>) -> ())?) {
        context = GifContext(session: session).execute { result in
            switch result {
            case .success(let imagePath):
                DispatchQueue.global().async {
                    let image = UIImage.gif(url: imagePath)
                    DispatchQueue.main.async {
                        completion?(Result.success(image))
                    }
                }
            case .failure(let error):
                completion?(Result.failure(error))
            }
        }
    }
    
    
}
