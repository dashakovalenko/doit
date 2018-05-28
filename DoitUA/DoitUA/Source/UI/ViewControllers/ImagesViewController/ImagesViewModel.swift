//
//  ImagesViewModel.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/28/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import Foundation

class ImagesViewModel {
    var images: [Image] = []
    
    var session: Session?
    var context: ImagesContext?
}

extension ImagesViewModel: ViewModel {
    typealias T = [Image]
    
    func loadData(completion: ((Result<[Image]>) -> ())?) {
        context = ImagesContext(session: session).execute { [weak self] result in
            switch result {
            case .success(let images):
                self?.images = images
            default:
                break
            }
            completion?(result)
        }
    }
}
