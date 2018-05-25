//
//  LoginContext.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/24/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

class LoginContext: NetworkContext<Session> {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    override func execute(_ completion: ((Result<Session>) -> (Void))?) -> Self {
        let keys = APIConfiguration.User.self
        let parameters = [keys.email: email as AnyObject, keys.password: password as AnyObject]
        networkRequest.sendRequest(with: .post,
                                   path: APIConfiguration.Paths.login,
                                   parameters: parameters,
                                   successHandler: Session.session,
                                   completion: completion)
        return self
    }
    
}

