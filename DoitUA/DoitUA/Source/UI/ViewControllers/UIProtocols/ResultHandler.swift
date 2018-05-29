//
//  ResultHandler.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol ResultHandler {
    associatedtype Model
    
    func handleResult(_ result: Result<Model>)
    func handleSuccess(_ data: Model)
}

protocol DataLoader: ResultHandler {
    var dataLoadCall: (((Result<Model>) -> ())?) -> Void { get }
}

extension ResultHandler where Self: ViewController {
    
    func handleResult(_ result: Result<Model>) {
        switch result {
        case .success(let data):
            handleSuccess(data)
        case .failure(let error):
            handleFailure(error)
        }
    }
    
    func handleFailure(_ error: Error) {
        showError(error, needCheck: true)
    }
    
}

extension DataLoader where Self: ViewController {
    func loadData() {
        dataLoadCall { result in
            self.handleResult(result)
        }
    }
}
