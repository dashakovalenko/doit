//
//  LoginPresenter.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/29/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

protocol LoginPresenter: RootPresenter {}

extension LoginPresenter {
    
    func showLoginScreen() {
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        setAsRoot(loginController)
    }
}
