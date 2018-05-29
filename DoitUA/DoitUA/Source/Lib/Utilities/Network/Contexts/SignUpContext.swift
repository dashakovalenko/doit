//
//  SignUpContext.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/23/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

fileprivate struct SignUp {
    static let errors = "errors"
    static let children = "children"
}

class SignUpContext: NetworkContext<Session> {
    let email: String
    let username: String?
    let password: String
    let avatar: UIImage
    
    //MARK: - Initializers
    
    init(email: String, username: String?, password: String, avatar: UIImage) {
        self.email = email
        self.username = username
        self.password = password
        self.avatar = avatar
    }
    
    //MARK: - Public methods
    
    override func execute(_ completion: ((Result<Session>) -> (Void))?) -> Self {
        let keys = APIConfiguration.User.self
        var parameters: [String: String] = [keys.email: email, keys.password: password]
        parameters[keys.username] = username

        self.networkRequest.sendMultpartRequest(with: APIConfiguration.Paths.create,
                                                parameters: parameters,
                                                image: avatar,
                                                imageKey: keys.avatar,
                                                successHandler: Session.session,
                                                failureHandler: parsedFailureMessage,
                                                completion: completion)

        return self
    }
    
    //MARK: - Private methods
    
    private func parsedFailureMessage(with json: [String: AnyObject]?) -> String? {
        guard let childrenJSON = json?[SignUp.children] as? [String: AnyObject] else {
            return nil
        }

        let keys = APIConfiguration.User.self
        let failures = [keys.email, keys.password, keys.avatar, keys.username].compactMap { key in
            ((childrenJSON[key] as? [String: AnyObject])?[SignUp.errors] as? [String])
                .map { key.capitalized + ": " + $0.joined(separator: " ") }
        }
        
        return failures.count > 0 ? failures.joined(separator: "\n") : nil
    }
    
}
