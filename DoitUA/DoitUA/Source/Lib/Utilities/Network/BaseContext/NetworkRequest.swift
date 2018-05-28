//
//  NetworkRequest.swift
//  DoitUA
//
//  Created by Daria Kovalenko on 5/24/18.
//  Copyright © 2018 Daria Kovalenko. All rights reserved.
//

import UIKit

final class NetworkRequest {
    static let wrongResponseString = "Wrong response"
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
    }

    var dataTask: URLSessionDataTask?

    //MARK: - Public methods
    
    func sendRequest<T>(with method: HTTPMethod,
                        path: String,
                        token: String? = nil,
                        parameters: [String: AnyObject]? = nil,
                        successHandler: @escaping (([String: AnyObject]?) -> T?),
                        failureHandler: (([String: AnyObject]?) -> String?)? = nil,
                        completion: ((Result<T>)-> ())?) {
        guard let requestURL = URL(string: APIConfiguration.baseURL + path) else {
            completion?(Result.failure(NSError.error(description: "Wrong request path")))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        var header = ["Content-Type": "application/json"]
        header[APIConfiguration.User.token] = token
        request.allHTTPHeaderFields = header
        
        request.httpBody = serialized(parameters)
        
        self.send(request, successHandler: successHandler, failureHandler: failureHandler, completion: completion)
    }
    
    func sendMultpartRequest<T>(with path: String,
                                parameters: [String: String],
                                image: UIImage,
                                imageKey: String,
                                token: String? = nil,
                                successHandler: @escaping (([String: AnyObject]?) -> T?),
                                failureHandler: (([String: AnyObject]?) -> String?)? = nil,
                                completion: ((Result<T>)-> ())?)
    {
        guard let requestURL = URL(string: APIConfiguration.baseURL + path),
            let orientedImage = image.oriented,
            let data = UIImageJPEGRepresentation(orientedImage, 0.3) else {
                completion?(Result.failure(NSError.error(description: "Wrong request parameters")))
                return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        token.map { request.allHTTPHeaderFields = [APIConfiguration.User.token: $0] }
        
        let boundary = String(format: "doitua.boundary.%08x%08x", arc4random(), arc4random())
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData(with: parameters, filePathKey: imageKey, imageDataKey: data, boundary: boundary)
     
        self.send(request, successHandler: successHandler, failureHandler: failureHandler, completion: completion)
    }
    
    func cancel() {
        self.dataTask?.cancel()
    }
    
    //MARK: - Private
    
    private func send<T>(_ request: URLRequest,
                         successHandler: @escaping (([String: AnyObject]?) -> T?),
                         failureHandler: (([String: AnyObject]?) -> String?)? = nil,
                         completion: ((Result<T>)-> ())?)
    {
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let result = self?.result(with: data, response: response, error: error, success: successHandler, failure:failureHandler) {
                DispatchQueue.main.async {
                    completion?(result)
                }
            }
        }
        task.resume()
        self.dataTask = task
    }
    
    private func serialized(_ parameters: [String: AnyObject]?) -> Data? {
        guard let dictionary = parameters,
            JSONSerialization.isValidJSONObject(dictionary) else {
            return nil
        }
        
        return try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    }
    
    private func result<T>(with data: Data?,
                        response: URLResponse?,
                        error: Error?,
                        success: (([String: AnyObject]?) -> T?),
                        failure: (([String: AnyObject]?) -> String?)?) -> Result<T>
    {
        if let error = error {
            return Result.failure(error)
        }
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            return Result.failure(NSError.error(description: NetworkRequest.wrongResponseString))
        }
    
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let json = jsonObject as? [String: AnyObject]
            switch response.statusCode {
            case 200, 201:
                if let successResult = success(json) {
                    return Result.success(successResult)
                }
                fallthrough
            default:
                let errorMessage = failure?(json) ?? parsedFailureMessage(with: json) ?? NetworkRequest.wrongResponseString
                let error = NSError.error(with: response.statusCode, description: errorMessage)
                
                return Result.failure(error)
            }
        } catch {
            return Result.failure(error)
        }
    }
    
    private func parsedFailureMessage(with json: [String: AnyObject]?) -> String? {
        return json?["error"] as? String
    }
    
    private func bodyData(with parameters: [String: String], filePathKey: String, imageDataKey: Data, boundary: String) -> Data {
        var body = Data();
        for (key, value) in parameters {
            body.append(Data("--\(boundary)\r\n".utf8))
            body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
            body.append(Data("\(value)\r\n".utf8))
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.append(Data("--\(boundary)\r\n".utf8))
        body.append(Data("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n".utf8))
        body.append(Data("Content-Type: \(mimetype)\r\n\r\n".utf8))
        body.append(imageDataKey)
        body.append(Data("\r\n".utf8))
        
        body.append(Data("--\(boundary)--\r\n".utf8))
        
        return body
    }
    
}
