//
//  LoginInCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/19/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

protocol AuthCoordinatorDelegate{
    func userDidChooseSignup()
    func userDidAuthenticate()
}
class AuthCoordinator :Coordinator{
    // MARK :- API
    var childCoordinators: [Coordinator] = []
    
    func addChildCoordinator(coordinator: Coordinator) {
        print ("add")
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        print ("remove")
    }
    
    func start() {
        self.navigationController?.show(self.loginViewController, sender: self)
    }
    
    // MARK :- private memebers
    
    fileprivate var navigationController : UINavigationController?
    fileprivate var loginViewController : LoginViewController!
    
   // weak var delegate : AuthCoordinatorDelegate?
    
    // MARK :- initializer
    init(with navigationControoler:UINavigationController) {
        self.navigationController = navigationControoler
        let loginViewModel = LoginViewModel()
        self.loginViewController = LoginViewController(with: loginViewModel)
    }
}
