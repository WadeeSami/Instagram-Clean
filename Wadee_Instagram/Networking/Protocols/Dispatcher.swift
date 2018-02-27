//
//  Dispatcher.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
protocol Dispatcher{
    func performRequest(request:InstagramRequest) throws
}
