//
//  Response.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

//inspired from https://github.com/malcommac/HermesNetwork/blob/master/Sources/ResponseProtocol.swift
import Foundation
protocol InstagramResponse {
    var statusCode: Int {get}
    
    var request:InstagramRequest {get}
    
    var httpResponse: HTTPURLResponse? {get}
    
    var data: Data? {get}
    
    func convertToJson()
    
}
