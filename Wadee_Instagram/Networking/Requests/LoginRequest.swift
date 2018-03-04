//
//  LoginRequest.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
public enum LoginRequest{
    case login (username:String,password:String )
}

extension LoginRequest:InstagramRequest{
    var path: String {
        switch self {
        case .login(username: _, password: _):
            return "login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .login(username: _, password: _):
                return .POST
        }
    }
    
    var parameters: [String:Any] {
        switch self {
        case .login(username: let userName, password: let password):
            return ["email": userName, "password": password]
        
        }
    }
    
    var header: [String : Any] {
        return [:]
    }
    
    
}
