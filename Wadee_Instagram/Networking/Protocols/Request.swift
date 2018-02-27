//
//  Request.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

public enum HTTPMethod:String{
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

protocol InstagramRequest{
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: [String:Any] {get}
    var header: [String: Any] {get}
    
}
