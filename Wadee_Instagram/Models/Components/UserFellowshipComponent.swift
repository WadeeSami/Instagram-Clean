//
//  UserFellowshipComponent.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/20/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
import SwiftyJSON
class UserFelloshipComponent{
    
    static func followUser(withUserId userId:Int, successHandler: @escaping ()->(), failureHandler: @escaping()->()){
        let loggedInUserId = AuthComponent.getLoggedInUserData()?.id
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("users/\(loggedInUserId!)/followers")
        SimpleNetworkUtility.performAlamoPostRequest(fromUrl: url, parameters: ["followed_user_id": userId], successHandler: {response in
            let json = JSON(response?.result.value as Any)
            if let statusCode = json["status_code"].int{
                if statusCode == 200{
                    successHandler()
                }else{
                    failureHandler()
                }
            }
        }, failureHandler: {error in
            print ("coulnt complete follow user")
        })

    }
}
