//
//  Post.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

struct Post {
    var id: Int
    var content:String
    var media: [Data]
    var mediaObjects: [PostMedia]?
    
    var postUser:User?
}


struct PostMedia {
    var id: Int
    var href_small:String
    var href_original:String
    var href_big:String
    var original_name :String
    
    var height:Double?
    var width:Double?
    var original_extension:String
    var type:String
    
}

/*
 {
 "id": 268,
 "created": "Mar 22, 2018 22:51:58 GMT",
 "content": "Liver Biopsy Consultation",
 "updated": "Mar 22, 2018 22:51:58 GMT",
 "media": [
 {
 "original_name": "IMAGE",
 "href_small": "/Users/Wadee/PycharmProjects/Instagram/core_instagram/media//post/268/33800e38b0a54c2496fdc4edc726eacd/240_240.JPEG",
 "height": 780,
 "width": 1366,
 "id": 188,
 "href_original": "/Users/Wadee/PycharmProjects/Instagram/core_instagram/media//post/268/33800e38b0a54c2496fdc4edc726eacd/original.JPEG",
 "original_extension": "JPEG",
 "type": "IMAGE",
 "href_big": "/Users/Wadee/PycharmProjects/Instagram/core_instagram/media//post/268/33800e38b0a54c2496fdc4edc726eacd/640_640.JPEG"
 }
 ]
 },
 */
