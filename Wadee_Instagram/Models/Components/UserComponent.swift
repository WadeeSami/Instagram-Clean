//
//  UserComponent.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

class UserComponent{
    static let USER_LOGIN_STATUS_KEY = "user_login_status_key"
    
    static func signUp(withUsername username:String,email:String, andPassword password:String ,completionHandler handler:(_ userInfo:String?, Error?)->()){
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("/registration")
        //        SimpleNetworkUtility.performGetRequest(fromUrl: url, successHandler: { data in }, failureHandler: {error in })
        SimpleNetworkUtility.performPostRequest(fromUrl: url, parameters: ["username":username, "email":email, "password":password], successHandler: {data in
            let res = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
        }, failureHandler: {error in
            print(error)
        })
        let loginEndpoint = InstagramAPI.signup
        let response = loginEndpoint.testingData
        let res = try? JSONSerialization.jsonObject(with: response, options: []) as! [String:Any]
        if res!["status_code"] as! Int != 200{
            handler(nil, InstagramAPIException.UserAlreadyExists)
        }else{
            handler(nil, nil)
        }
    }
    
    static func setUserLoginStatus(loggedIn:Bool){
        UserDefaults.standard.set(loggedIn, forKey: USER_LOGIN_STATUS_KEY)
    }
    
    static func isUserLoggedIn()->Bool{
        return UserDefaults.standard.bool(forKey: USER_LOGIN_STATUS_KEY) 
    }
}
