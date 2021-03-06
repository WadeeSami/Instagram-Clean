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
struct User :Codable{
    var id :Int?
    var username:String
    var userMedia:UserMedia?
    var in_fellowship:Bool = false
    

}

struct UserMedia :Codable{
    var id: Int
    var href_small:String
    var href_original:String
    var href_big:String
    var original_name :String
    
    var height:Double?
    var width:Double?
    var original_extension:String
    
//    var propertyListRepresentation : [String:String] {
//        return ["id" : "\(self.id)", "href_small" : self.href_small, "href_big":self.href_big, "href_original":self.href_original, "height":"\(String(describing: self.height))", "width" :"\(String(describing: self.width))"]
//    }
    
}
