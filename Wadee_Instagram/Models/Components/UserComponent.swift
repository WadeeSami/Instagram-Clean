//
//  UserComponent.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserComponent{
    static let USER_LOGIN_STATUS_KEY = "user_login_status_key"
    
    static func signUp(withUsername username:String,email:String, andPassword password:String ,completionHandler handler:(_ userInfo:String?, Error?)->()){
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("/registration")
        //        SimpleNetworkUtility.performGetRequest(fromUrl: url, successHandler: { data in }, failureHandler: {error in })
        SimpleNetworkUtility.performPostRequest(fromUrl: url, parameters: ["username":username, "email":email, "password":password], successHandler: {data in
            _ = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
        }, failureHandler: {error in
            print(error!)
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
    
    static func login(with username:String, and password:String, successHandler: @escaping ()->(), failureHandler: @escaping ()->()){
        //convert the images to data
        
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("/login")
        
        let params = ["email":username, "password":password]
        SimpleNetworkUtility.performAlamoPostRequest(fromUrl: url, parameters: params, successHandler: { response in
            
            let jsonResponse = JSON(response?.result.value as Any)
            if let statusCode = jsonResponse["status_code"].int{
                let successRange = 200..<300
                if successRange.contains(statusCode) {
                    print ("success")
                }else{
                    print ("WTH")
                }
            }
            print(jsonResponse)
            //handle cookies token
            guard let authToken = response?.response?.allHeaderFields[AuthComponent.AUTH_TOKEN_NAME] as? String else{
                //raise exception or simething
                return
            }
            AuthComponent.storeAuthToken(authToken: authToken)
            
            
            successHandler()
        }, failureHandler: {error in
            print ("eerrr")
            failureHandler()
        })
        
    }
}
