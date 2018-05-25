//
//  LoginViewModel.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class LoginViewModel {

    var email: String?
    var password: String?
    
    var context: LoginContext?

}

extension LoginViewModel: ViewModel {
    typealias T = Session
    func loadData(completion: ((Result<Session>) -> ())?) {
        guard let email = email, !email.isEmpty,
            let password = password, !password.isEmpty else {
                completion?(Result<Session>.failure(NSError.error(description: "Fields should not be empty")))
                return
        }

        self.context = LoginContext(email: email, password: password).execute(completion)
    }

}
