//
//  LoginTask.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/27/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
class LoginTask:Task{
    func execute(handler: @escaping (InstagramResponse) -> ()) throws {
        let dispatcher = RegularDispatcher()
        try dispatcher.performRequest(request: self.request, request_completion_handler: { response in
            handler(response)
        })
    }
    
    var request: InstagramRequest
    
    init(with request:InstagramRequest) {
        self.request = request
    }
    
    
}

