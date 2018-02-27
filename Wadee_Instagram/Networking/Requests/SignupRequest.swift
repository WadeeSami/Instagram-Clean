//
//  SignupRequest.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

enum SignupReuest{
    case signup(username:String, password:String, email:String)
}

extension SignupReuest:InstagramRequest{
    var path: String {
        return "signup"
    }
    
    var method: HTTPMethod {
        return .POST
    }
    
    var parameters: [String : Any] {
        switch self {
        case .signup(username: let username, password: let password, email: let email):
            return ["username":username, "password":password, "email":email]
        }
    }
    
    var header: [String : Any] {
        return [:]
    }
    
    
}
