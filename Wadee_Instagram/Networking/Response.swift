//
//  Response.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/1/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
class Response:InstagramResponse{
    var error: Error?
    
    var statusCode: Int
    
    var request: InstagramRequest
    
    var httpResponse: HTTPURLResponse?
    
    var data: Data?
    
    init(with response:HTTPURLResponse, andData data:Data?, forRequest request:InstagramRequest, withError error:Error? ) {
        self.data = data
        self.httpResponse = response
        self.statusCode = response.statusCode 
        self.request = request
        self.error = error
    }
}
