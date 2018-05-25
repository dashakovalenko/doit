//
//  Session.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/24/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

struct Session {
    let token: String
    
    static func session(with json: [String: AnyObject]?) -> Session? {
        guard let token = json?[APIConfiguration.User.token] as? String else {
            return nil
        }
        
        return Session(token: token)
    }

}
