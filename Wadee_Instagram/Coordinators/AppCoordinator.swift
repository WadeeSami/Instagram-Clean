//
//  AppCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/19/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit


class AppCoordinator :Coordinator{
    
    // MARK :- private memebers
    internal var childCoordinators : [Coordinator] = []
    
    fileprivate let rootViewController: UINavigationController!
    
    fileprivate  var isLoggedIn = false
    
    // MARK : Initializers
    init(with rootViewControler:UINavigationController) {
        self.rootViewController = rootViewControler
    }
    
    func start() {
        //check for auth and session
        if self.isLoggedIn {
            // show profile page
        }else {
            self.startAuthenticationFlow()
            print ("starting te auth flow")
        }
        
    }
    
    func addChildCoordinator(coordinator: Coordinator) {
        print("Hello")
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        print("remove")
    }
    
    
}

extension AppCoordinator{
    func startAuthenticationFlow(){
        let authCoordinator = AuthCoordinator(with: self.rootViewController)
        self.addChildCoordinator(coordinator: authCoordinator)
        //register any deligate !
        authCoordinator.start()
    }
}
//extension for sub coordinators

