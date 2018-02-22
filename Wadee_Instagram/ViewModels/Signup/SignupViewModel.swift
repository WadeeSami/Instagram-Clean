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
    
    
    //MARK: API methods
    func signup(){
        
//        self.signupCoordinatorDelegate?.userDidSignUp()
    }
    
    func goToLogin(){
        self.signupCoordinatorDelegate?.userChoseLogin()
    }
    
    //MARK: private methods
    private func validateSignupMembers()->Bool{
        return Validator.validateEmail(email: self.email!) && Validator.validatePassword(password: self.password!)
    }
}
