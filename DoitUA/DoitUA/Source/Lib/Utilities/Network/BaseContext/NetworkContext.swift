//
//  NetworkContext.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/24/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class NetworkContext<T>: Context {

    internal var networkRequest: NetworkRequest = NetworkRequest()
    
    func execute(_ completion: ((Result<T>) -> (Void))?) -> Self {
        return self
    }

    func cancel() {
        networkRequest.cancel()
    }
}
