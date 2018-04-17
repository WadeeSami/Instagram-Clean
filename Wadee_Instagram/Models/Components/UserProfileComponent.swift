//
//  UserProfileComponent.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/29/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserProfileComponent{
    static func fetchUserPostImages(limit:Int = 10, offset:Int = 0, completion: @escaping ([Post]?) -> Void) {
        let postURL = SimpleNetworkUtility.baseUrl.appendingPathComponent("/posts")
        Alamofire.request(
            postURL,
            method: .get,
            parameters: [:])
            .validate()
            .responseJSON { (response) -> Void in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    var postsList = [Post]()
                    if json["status_code"].int == 200{
                        for (_, jsonPost) in json["data"]{
                            
                            var post = Post(id: jsonPost["id"].int!, content: jsonPost["content"].stringValue, media: [], mediaObjects: [], postUser: nil)
                            if jsonPost["media"].exists() {
                                var postMediaList = [PostMedia]()
                                for (_, media) in jsonPost["media"]{
                                    postMediaList.append(PostMedia(id: media["id"].int!, href_small: media["href_small"].string!, href_original: media["href_original"].string!, href_big: media["href_big"].string!, original_name: media["original_name"].string!, height: media["height"].double, width: media["width"].double, original_extension: media["original_extension"].string!, type: media["type"].string!))
                                }
                                post.mediaObjects = postMediaList
                            }
                            
                            if jsonPost["user_info"].exists() {
                                let user_info_dict = jsonPost["user_info"]
                                var postUserInfo = User(id:user_info_dict["id"].int ,username: user_info_dict["username"].string!, userMedia:nil)
                                if (!user_info_dict["profile_image"].isEmpty ){
                                    let media_dict = user_info_dict["profile_image"]
                                    
                                    let user_media = UserMedia(id: 1, href_small: media_dict["href_small"].string!, href_original: media_dict["href_original"].string!, href_big: media_dict["href_big"].string!, original_name: "user_info", height: nil, width: nil, original_extension: "JPEG")
                                    postUserInfo.userMedia = user_media
                                }
                                
                                post.postUser = postUserInfo
                            }
                            postsList.append(post)
                        }
                        completion(postsList)
                    }
                    
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
    
}
