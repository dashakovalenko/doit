//
//  APIConfiguration.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/24/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import Foundation

struct APIConfiguration {
    static let baseURL = "http://api.doitserver.in.ua/"
    
    struct Paths {
        static let create = "create"
        static let login = "login"
        static let image = "image"
        static let all = "all"
        static let gif = "gif"
    }
    
    struct User {
        static let email = "email"
        static let password = "password"
        static let username = "username"
        static let avatar = "avatar"
        static let token = "token"
    }
    
    struct Image {
        static let image = "image"
        static let description = "description"
        static let hashtag = "hashtag"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let weather = "weather"
        static let id = "id"
        static let imagePath = "smallImagePath"
        static let parameters = "parameters"
        static let address = "address"
    }
    
}


