//
//  NetworkLayer.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/23/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
typealias successHandler = (_ response:Data?)->()
typealias failureHandler  = (_ error:Error?)-> ()

protocol NetworkLayer{
    static var baseUrl:URL {get}
    static func performGetRequest(fromUrl url:URL, successHandler: @escaping successHandler, failureHandler: @escaping failureHandler)
}
