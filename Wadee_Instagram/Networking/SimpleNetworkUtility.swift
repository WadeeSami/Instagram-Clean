//
//  SimpleNetworkUtility.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/23/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

struct SimpleNetworkUtility : NetworkLayer{
    #if DEVELOPMENT
    let SERVER_URL = "http://localhost/api/v1"
    let API_TOKEN = "asfasdadasdass"
    #else
    let SERVER_URL = "http://dev.localhost.com/api/v1"
    let API_TOKEN = "fgbfkbkgbmkgbm"
    #endif
    
    static var baseUrl: URL = URL(string: "http://localhost:7000/api/v1")!
    static func performGetRequest(fromUrl url: URL, successHandler: @escaping successHandler, failureHandler: @escaping failureHandler) {
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error {
                failureHandler(error)
            }else{
                successHandler(data)
            }
            
            }.resume()
    }
    
}
