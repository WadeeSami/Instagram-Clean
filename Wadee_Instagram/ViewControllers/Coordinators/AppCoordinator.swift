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
    
    fileprivate  var isLoggedIn = UserComponent.isUserLoggedIn()
    
    // MARK : Initializers
    init(with rootViewControler:UINavigationController) {
        self.rootViewController = rootViewControler
    }
    
    func start() {
        //check for auth and session
        if self.isLoggedIn {
            // show profile page
            self.startProfileFlow()
        }else {
            self.startAuthenticationFlow()
            print ("starting te auth flow")
        }
        
    }
    
    func addChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        print("remove")
    }
    
    
}

extension AppCoordinator{
    func startAuthenticationFlow(){
        let authCoordinator = AuthCoordinator(with: self.rootViewController)
        authCoordinator.authCoordinatorDelegate = self
        self.addChildCoordinator(coordinator: authCoordinator)
        //register any deligate !
        authCoordinator.start()
    }
    
    func startProfileFlow(){
        let mainBarCoordinator = MainBarCoordinator(with: self.rootViewController, andAppCoordinator: self)
        self.addChildCoordinator(coordinator: mainBarCoordinator)
        mainBarCoordinator.start()
        
        //        let profileCoordinator = ProfileCoordinator(with: self.mainTabBarController)
        //        self.addChildCoordinator(coordinator: profileCoordinator)
        //        profileCoordinator.profileCoordinatorDelegate = self
        //        profileCoordinator.start()
    }
    
}
//extension for sub coordinators
extension AppCoordinator: AuthCoordinatorDelegate{
    
    func userDidAuthenticate() {
        //remove auth coordinator
        
        self.childCoordinators.removeLast()
        self.rootViewController.popViewController(animated: true)
        self.startProfileFlow()
    }
    
    
}

extension AppCoordinator: ProfileCoordinatorDelegate{
    func userDidTapLogout() {
        UserComponent.setUserLoginStatus(loggedIn: false)
        self.childCoordinators.removeLast()
        self.startAuthenticationFlow()
    }
}




