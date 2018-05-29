//
//  GifContext.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class GifContext: NetworkContext<String> {
    let session: Session?
    
    init(session: Session?) {
        self.session = session
    }
    
    override func execute(_ completion: ((Result<String>) -> (Void))?) -> Self {
        networkRequest.sendRequest(with: .get,
                                   path: APIConfiguration.Paths.gif,
                                   token: session?.token,
                                   successHandler: { $0?["gif"] as? String },
                                   completion: completion)
        
        return self
    }
}
