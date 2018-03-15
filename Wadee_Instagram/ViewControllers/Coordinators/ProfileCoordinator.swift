//
//  ProfileCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/24/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

protocol ProfileCoordinatorDelegate:class{
    func userDidTapLogout()
}
class ProfileCoordinator:NSObject, Coordinator{
    weak public var profileCoordinatorDelegate:ProfileCoordinatorDelegate?
    
    private var rootViewController:InstagtamMainBarController!
    
     init(with tabBarController: InstagtamMainBarController) {
        super.init()
        self.rootViewController = tabBarController
    }
    
    func start() {
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        profileViewController.profileViewModel = profileViewModel
        profileViewController.profileCoordinator = self
        self.rootViewController.show(profileViewController, sender: self)
        
    }
    
    var childCoordinators: [Coordinator] = []
    
    func addChildCoordinator(coordinator: Coordinator) {
        //
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        //
    }
    
    func logout(){
        //go to sign up
        profileCoordinatorDelegate?.userDidTapLogout()
    }
    
}
