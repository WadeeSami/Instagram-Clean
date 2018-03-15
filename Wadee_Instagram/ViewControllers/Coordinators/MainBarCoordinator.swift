//
//  MainBarCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/9/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class MainBarCoordinator:NSObject,Coordinator{
    fileprivate lazy var mainTabBarController = InstagtamMainBarController(with: self)
    fileprivate var rootViewController:UINavigationController
    fileprivate var appCoordinator:AppCoordinator?
    
    init(with rootViewController:UINavigationController, andAppCoordinator appCoordinator:AppCoordinator) {
        self.rootViewController = rootViewController
        self.appCoordinator = appCoordinator
    }
    func start() {
        //show the profile first
        self.mainTabBarController.delegate = self
        self.rootViewController.present(self.mainTabBarController, animated: true, completion: nil)
    }
    
    var childCoordinators: [Coordinator] = []
    
    func addChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {

    }
    
}
//extension for sub coordinators

extension MainBarCoordinator: ProfileCoordinatorDelegate{
    func userDidTapLogout() {
        UserComponent.setUserLoginStatus(loggedIn: false)
        //call upper coord to show the signin
        self.rootViewController.dismiss(animated: true, completion: nil)
        self.appCoordinator?.userDidTapLogout()
    }
}


extension MainBarCoordinator: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print ("sonthing selected")
        
    }
    
}


