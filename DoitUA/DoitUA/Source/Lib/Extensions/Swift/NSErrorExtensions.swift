//
//  ErrorExtensions.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import Foundation

extension NSError {
    
    class func error(with errorCode: Int = 999, description: String) -> NSError {
        return NSError(domain: "ua.doit",
                       code: errorCode,
                       userInfo: [NSLocalizedDescriptionKey : description])
    }
    
}
