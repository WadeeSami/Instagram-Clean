//
//  Request.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

public enum HTTPMethod{
    case GET
    case POST
    case PUT
    case DELETE
}

protocol InstagramRequest{
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: [String:Any] {get}
    var header: [String: Any] {get}
    
}
