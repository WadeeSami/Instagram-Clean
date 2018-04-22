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
    private static func extractUserImage(userInfo:JSON)->UserMedia?{
        if !userInfo["profile_image"].isEmpty{
            let media_dict = userInfo["profile_image"]
            
            let user_media = UserMedia(id: 1, href_small: media_dict["href_small"].string!, href_original: media_dict["href_original"].string!, href_big: media_dict["href_big"].string!, original_name: "user_info", height: nil, width: nil, original_extension: "JPEG")
            return user_media
        }
        
        return nil
    }
    
    static let USER_LOGIN_STATUS_KEY = "user_login_status_key"
    
    static func signUp(withUsername username:String,email:String, andPassword password:String ,completionHandler handler:(_ userInfo:String?, Error?)->()){
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("/registration")
        //        SimpleNetworkUtility.performGetRequest(fromUrl: url, successHandler: { data in }, failureHandler: {error in })
        SimpleNetworkUtility.performPostRequest(fromUrl: url, parameters: ["username":username, "email":email, "password":password], successHandler: {data in
            _ = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
        }, failureHandler: {error in
            print(error!)
        })
//        let loginEndpoint = InstagramAPI.signup
//        let response = loginEndpoint.testingData
//        let res = try? JSONSerialization.jsonObject(with: response, options: []) as! [String:Any]
//        if res!["status_code"] as! Int != 200{
//            handler(nil, InstagramAPIException.UserAlreadyExists)
//        }else{
//            handler(nil, nil)
//        }
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
            //handle cookies token
            guard let authToken = response?.response?.allHeaderFields[AuthComponent.AUTH_TOKEN_NAME] as? String else{
                //raise exception or simething
                return
            }
            AuthComponent.storeAuthToken(authToken: authToken)
            
            //store user info
            if jsonResponse["data"].exists(), let userData = response?.result.value as? [String:Any]{
                
                AuthComponent.saveLoggedInUserData(userDict: userData["data"] as! [String : Any])
            }
            
            successHandler()
        }, failureHandler: {error in
            print ("eerrr")
            failureHandler()
        })
        
    }
    
    static func searchUsersWith(searchTerm:String, successHandler: @escaping ([User])->(), failureHandler: @escaping ()->()){
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("/users")
        SimpleNetworkUtility.performAlamofireGetRequest(fromUrl: url, parameters: ["search_term":searchTerm], successHandler: {response in
            var usersList = [User]()
            let json = JSON(response?.result.value! as Any)
            guard let statusCode = json["status_code"].int, statusCode == 200 else{
                print ("status code eeror")
                return
            }
            if let jsonData = json["data"].array  {
                for subJson in jsonData {
                    let is_followed = subJson["in_fellowship"].exists() ? subJson["in_fellowship"].bool : false
                    var user = User(id: subJson["id"].int, username: subJson["username"].string!, userMedia: nil, in_fellowship: is_followed!)
                    user.userMedia = UserComponent.extractUserImage(userInfo: subJson)
                    usersList.append(user)
                }
            }
            successHandler(usersList)
        }, failureHandler: {error in
            print ("Horrible Error")
        })
    }
    
    static func getUserInfo(withUserId userId:Int, success:@escaping (User)-> ()){
        var user : User?
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("/users/\(userId)")
        SimpleNetworkUtility.performAlamofireGetRequest(fromUrl: url, parameters: [:], successHandler: {response in
            let json = JSON(response?.result.value as Any)
            guard let statusCode = json["status_code"].int, statusCode == 200 else{
                print ("status code error")
                return
            }
            if let userJson = json["data"].dictionary{
                let is_followed:Bool
                if userJson["in_fellowship"] != nil{
                    is_followed = (userJson["in_fellowship"]?.bool)!
                }else{
                    is_followed = false
                }
            
                user = User(id: userJson["id"]?.int!, username: (userJson["username"]?.string)!, userMedia: nil, in_fellowship: is_followed)
                success(user!)
            }
            
        }, failureHandler: {error in
            print ("error in fetch user info api")
        })
        
        
    }
}
