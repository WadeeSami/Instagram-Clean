//
//  Validator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/20/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

class Validator{
    static func validatePassword(password:String)->Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func validateEmail(email:String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
