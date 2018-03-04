//
//  Dispatcher.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
typealias completion_handler = (InstagramResponse) -> ()
protocol Dispatcher{
    func performRequest(request:InstagramRequest, request_completion_handler:@escaping completion_handler) throws
}
