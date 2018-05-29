//
//  RootPresenter.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol RootPresenter {}

extension RootPresenter {
    
    func setAsRoot(_ viewController: UIViewController?) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}
