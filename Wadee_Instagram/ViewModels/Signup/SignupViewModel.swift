//
//  SignupViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

protocol SignupViewModelCoordinatorDelegate{
    func userDidSignUp()
    func userChoseLogin()
}

protocol SignUpViewModelDelegate{
    func invalidFieldsSubmitted(errorMessage message:String)
}
struct SignupViewModel{
    //MARK: delegate
    var signupCoordinatorDelegate:SignupViewModelCoordinatorDelegate?
    var signupViewModelDelegate:SignUpViewModelDelegate?
    
    //MARK: public properties
    var username:String?
    var email:String?
    var password:String?
    var profileImage: UIImage?
    
    //MARK: API methods
    func signup()throws{
        try validateSignupMembers()
        UserComponent.signUp(withUsername: self.username!, email: self.email!, andPassword: self.password!){ userInfo, error in
            if let error = error{
                //do something !!
                print(error.localizedDescription)
            }else{
                print("signupSuccessfully")
            }
        }
        self.signupCoordinatorDelegate?.userDidSignUp()
    }
    
    func goToLogin(){
        self.signupCoordinatorDelegate?.userChoseLogin()
    }
    
    //MARK: private methods
    private func validateSignupMembers()throws{
        guard Validator.validateEmail(email: self.email!) else{
            throw FieldValidationError.InvalidEmail
        }
        
        guard Validator.validatePassword(password: self.password!) else{
            throw FieldValidationError.InvalidPassword
        }
        
        guard Validator.validateUsername(username: self.username!) else{
            throw FieldValidationError.InvalidUsername
        }
        
    }
}
