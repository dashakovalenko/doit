//
//  SignUpViewModel.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/25/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class SignUpViewModel {
    
    var email: String?
    var password: String?
    var avatar: UIImage?
    var username: String?
    
    var context: SignUpContext?
    
}

extension SignUpViewModel: ViewModel {
    typealias T = Session
    
    func loadData(completion: ((Result<Session>) -> ())?) {
        guard let email = email, !email.isEmpty,
            let password = password, !password.isEmpty else {
                completion?(Result<Session>.failure(NSError.error(description: "Fields should not be empty")))
                return
        }
        
        guard let avatar = avatar else {
            completion?(Result<Session>.failure(NSError.error(description: "You should select profile picture")))
            return
        }
        
        self.context = SignUpContext(email: email, username: username, password: password, avatar: avatar)
            .execute(completion)
    }
    
}
