//
//  UserComponent.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

class UserComponent{
    static func signUp(withUsername username:String,email:String, andPassword password:String ,completionHandler handler:(_ userInfo:String?, Error?)->()){
        let loginEndpoint = InstagramAPI.signup
        let response = loginEndpoint.testingData
        let res = try? JSONSerialization.jsonObject(with: response, options: []) as! [String:Any]
        if res!["status_code"] as! Int != 200{
            handler(nil, InstagramAPIException.UserAlreadyExists)
        }else{
            handler(nil, nil)
        }
    }
}
