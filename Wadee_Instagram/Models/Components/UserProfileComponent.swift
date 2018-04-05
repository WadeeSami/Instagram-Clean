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
        print("This is the url \(postURL)")
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
                            
                            var post = Post(id: jsonPost["id"].int!, content: jsonPost["content"].stringValue, media: [], mediaObjects: [])
                            if jsonPost["media"].exists() {
                                var postMediaList = [PostMedia]()
                                for (_, media) in jsonPost["media"]{
                                    postMediaList.append(PostMedia(id: media["id"].int!, href_small: media["href_small"].string!, href_original: media["href_original"].string!, href_big: media["href_big"].string!, original_name: media["original_name"].string!, height: media["height"].double, width: media["width"].double, original_extension: media["original_extension"].string!, type: media["type"].string!))
                                }
                                post.mediaObjects = postMediaList
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
