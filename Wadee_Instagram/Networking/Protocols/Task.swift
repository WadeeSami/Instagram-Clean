//
//  Task.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/27/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
protocol Task {
    
    /// Request to execute
    var request: InstagramRequest { get }
    
    
    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    /// - Returns: a promise
    func execute() throws
    
}
