//
//  Exceptions.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/23/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

protocol InstagramErrorType{
    var relatedMessage:String {get}
}
enum InstagramAPIException:Error, InstagramErrorType{
    var relatedMessage: String{
        switch self {
        case .InvalidCredentials:
            return "Invalid Creduntials"
        case .UserAlreadyExists:
            return "User Already Exists"
        default:
            return ""
        }
    }
    
    
    case InvalidCredentials
    case UserAlreadyExists
    case EmailAlreadyUsed
    case PhoneAlreadyUsed
    
}

enum FieldValidationError: InstagramErrorType, Error{
    var relatedMessage: String{
        switch self {
        case .InvalidEmail:
            return "Invalid Email Address"
        case .InvalidPassword:
            return "Password Should be .."
        case .InvalidUsername:
            return "Username should not contain. .."
            
        }
    }
    
    case InvalidEmail
    case InvalidPassword
    case InvalidUsername
    
    
}


