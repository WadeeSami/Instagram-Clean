//
//  LoginViewModel.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/19/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation

//protocol LoginViewModelSpecification{
//    var email:String {get set}
//    var password:String {get set}
//    func signIn(email:String, password:String)
//
//}
//
protocol LoginViewModelDelegate {
    func invalidFieldsFormatUsed(errorMessage:String)
}

protocol LoginViewModelCoordinatorDelegate{
    func userDidLogin()
    func userDidChooseSignup()
}
//TODO: centralize Error Handling with a base class
enum LoginError:Error{
    case InvalidLoginParamsError
    case InvalidCredintials
}
class LoginViewModel{
    
    var loginVMDelegate: LoginViewModelDelegate?
    var loginCoordinatorDelegate:LoginViewModelCoordinatorDelegate?
    var email: String?
    var password: String?
    
    
    func signin()throws  {
        try validateLoginParams(email: self.email!, password: self.password!)
        
        let loginTask = LoginTask(with: LoginRequest.login(username: "test@test.com", password: "123123"))
        do{
            try loginTask.execute()
        }catch let e{
            print ("What the heck is this\(e.localizedDescription)")
        }
        
//        let loginEndpoint = InstagramAPI.login
//        let response = loginEndpoint.testingData
//        let res = try? JSONSerialization.jsonObject(with: response, options: []) as! [String:Any]
//        if res!["status_code"] as! Int != 200{
//            print ("Logged In User")
//        }else{
//            self.loginCoordinatorDelegate?.userDidLogin()
//        }
    }
    
    
    private func validateLoginParams(email:String, password:String)throws {
        guard Validator.validatePassword(password: password) else{
            throw FieldValidationError.InvalidPassword
        }
        guard Validator.validateEmail(email: email) else{
            throw FieldValidationError.InvalidEmail
        }
    }
    
    func goToSignUp(){
        self.loginCoordinatorDelegate?.userDidChooseSignup()
    }
}




