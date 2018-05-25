//
//  Context.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/24/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol Context {
    associatedtype T
    typealias ResponseHandler = (Result<T>) -> (Void)

    func execute(_ completion: ResponseHandler?) -> Self
    func cancel()
}
