//
//  SearchUsersCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/15/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
class SearchUsersCoordinator:NSObject, Coordinator{
    public var rootViewController:UINavigationController?
    
    func start() {
        //
    }
    
    var childCoordinators: [Coordinator] = []
    
    func addChildCoordinator(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        //
    }
    
    
}

extension SearchUsersCoordinator{
    func userTabClicked(userId: Int) {
        let profileViewModel = ProfileViewModel()
        profileViewModel.userId = userId
        let profileViewController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        profileViewController.profileViewModel = profileViewModel
        profileViewController.profileControllerMode = ProfileViewControllerMode.DISPLAY_PROFILE_PAGE
        
        self.rootViewController?.pushViewController(profileViewController, animated: true)
    }
}
