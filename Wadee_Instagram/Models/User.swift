//
//  User.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/23/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
protocol InstagramBaseModel:Codable{
    var id:Int{get set}
    func translateToJson()
}
struct User {
    var username:String
    var userMedia:UserMedia?
}

struct UserMedia {
    var id: Int
    var href_small:String
    var href_original:String
    var href_big:String
    var original_name :String
    
    var height:Double?
    var width:Double?
    var original_extension:String
    
    
}
