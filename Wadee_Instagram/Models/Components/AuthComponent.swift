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
    
    static func saveLoggedInUserData(userDict:[String:Any]){
        if let id = userDict["id"] , let username = userDict["username"] {
            let user = User(id: id as? Int, username: username as! String, userMedia: nil)
            let encodedUser = try? JSONEncoder().encode(user)
            UserDefaults.standard.set(encodedUser, forKey: "logged_in_user")
        }
        
    }
    
    static func getLoggedInUserData()->User?{
        
        let encodedUser =  UserDefaults.standard.object(forKey: "logged_in_user")
        let user = try? JSONDecoder().decode(User.self, from: encodedUser as! Data)
        return user
    }
    
}
