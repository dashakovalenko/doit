//
//  ImagesContext.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/28/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import Foundation

class ImagesContext: NetworkContext<[Image]> {
    
    let session: Session?
    
    init(session: Session?) {
        self.session = session
    }
    
    override func execute(_ completion: ((Result<[Image]>) -> (Void))?) -> Self {
        networkRequest.sendRequest(with: .get,
                                   path: APIConfiguration.Paths.all,
                                   token: session?.token,
                                   successHandler: { json in
                                    (json?["images"] as? [[String: AnyObject]])?.compactMap(Image.image)
        },
                                   completion: completion)
        return self
    }
}
