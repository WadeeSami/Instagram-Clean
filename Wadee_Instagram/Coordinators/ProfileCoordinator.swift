//
//  ProfileCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/24/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class ProfileCoordinator:NSObject, Coordinator{
    private var rootViewController:UINavigationController!
    
     init(with navController: UINavigationController) {
        super.init()
        self.rootViewController = navController
    }
    
    func start() {
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        profileViewController.viewModel = profileViewModel
        profileViewController.coordinator = self
        self.rootViewController.show(profileViewController, sender: self)
        
    }
    
    var childCoordinators: [Coordinator] = []
    
    func addChildCoordinator(coordinator: Coordinator) {
        //
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        //
    }
    
    
}
