//
//  ViewModel.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol ViewModel {
    associatedtype T
    func loadData(completion: ((Result<T>) -> ())?)
}
