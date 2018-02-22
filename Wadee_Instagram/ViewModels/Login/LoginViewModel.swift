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
    
    
    func signin(completionHandler: @escaping (_ error:Error?) -> ())  {
        if !self.validateLoginParams(email:self.email! , password: self.password!){
            self.loginVMDelegate?.invalidFieldsFormatUsed(errorMessage: "Invalid Fields")
            return
        }
        let loginEndpoint = InstagramAPI.login
        let response = loginEndpoint.testingData
        let res = try? JSONSerialization.jsonObject(with: response, options: []) as! [String:Any]
        if res!["status_code"] as! Int != 200{
            completionHandler(LoginError.InvalidCredintials)
        }else{
            completionHandler(nil)
            self.loginCoordinatorDelegate?.userDidLogin()
        }
    }
    
    
    private func validateLoginParams(email:String, password:String)->Bool {
        return Validator.validatePassword(password: password) && Validator.validateEmail(email: email)
    }
    
    func goToSignUp(){
        self.loginCoordinatorDelegate?.userDidChooseSignup()
    }
}




