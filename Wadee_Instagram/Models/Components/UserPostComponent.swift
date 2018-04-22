//
//  UserMediaComponent.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit


class UserPostsComponent{
    static func addUserPost(with media:[UIImage]?, andContent content:String, successHandler: @escaping ()->(), failureHandler: @escaping ()->()){
        //convert the images to data
        var encodedMedia = [Data]()
        if let media = media{
            for image in media{
                encodedMedia.append(UIImageJPEGRepresentation(image, 0.5)!)
            }
        }
        _ = Post(id: -1, content: content, media: encodedMedia, mediaObjects: [], postUser: nil)
        let userId = AuthComponent.getLoggedInUserData()?.id
        let url = SimpleNetworkUtility.baseUrl.appendingPathComponent("users/\(String(describing: userId!))/posts")
        
        SimpleNetworkUtility.performMultipartRequest(fromUrl: url, parameters: ["content":content],images:encodedMedia, successHandler: {data in
            successHandler()
            
        }, failureHandler: {error in
            failureHandler()
        })
        
    }
}
