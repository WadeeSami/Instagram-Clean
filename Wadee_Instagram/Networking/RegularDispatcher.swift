//
//  Dispatcher.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/27/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

public enum NetworkErrors: Error {
    case badInput
    case noData
}

class RegularDispatcher:Dispatcher{
    func performRequest(request: InstagramRequest) throws {
        let urlRequest = try self.prepareRequest(request: request)
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {(data, response, error) in
            print (data)
            print(error)
            print(response)
        }).resume()
    }
    
    
}
extension RegularDispatcher{
    private func prepareRequest(request: InstagramRequest)throws->URLRequest?{
        let fullUrl = SimpleNetworkUtility.baseUrl.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = request.method.rawValue
        
        switch request.method {
        case HTTPMethod.DELETE,HTTPMethod.GET:
            if let params = request.parameters as? [String: String] { // just to simplify
                let query_params = params.map({ (element) -> URLQueryItem in
                    return URLQueryItem(name: element.key, value: element.value)
                })
                guard var components = URLComponents(string: fullUrl.absoluteString) else {
                    //throwSomething
                    return nil
                }
                components.queryItems = query_params
                urlRequest.url = components.url
            } else {
                //do something
            }
        case HTTPMethod.POST,HTTPMethod.PUT:
            if let params = request.parameters as? [String: String] { // just to simplify
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
            } else {
                return nil
            }
        }
        return urlRequest
    }
}
