//
//  AuthComponent.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/5/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

struct AuthComponent {
    static let AUTH_TOKEN_NAME = "Set-Cookie"
    
    static func storeAuthToken(authToken:String){
        UserDefaults.standard.set(authToken, forKey: AUTH_TOKEN_NAME)
    }
    
    static func getUserAuthToken(authToken:String)-> String{
        return UserDefaults.standard.value(forKey: AUTH_TOKEN_NAME) as! String
    }
}
