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
struct User:Codable {
    var first_name:String
}
