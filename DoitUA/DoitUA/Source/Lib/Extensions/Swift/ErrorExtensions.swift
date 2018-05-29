//
//  ErrorExtensions.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import Foundation

extension Error {
    
    var isAuth: Bool {
        return (self as NSError).code == 403
    }
    
}
