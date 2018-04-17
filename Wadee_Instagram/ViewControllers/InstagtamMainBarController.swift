//
//  InstagtamMainBarController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/9/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class InstagtamMainBarController:UITabBarController{
    //TODO: consider moving controller's related logic to the coordinator !!
    
    //MARK: private vars
    fileprivate var tabBarCoordinator: MainBarCoordinator?
    
    //MARK: initializers
    init(with barCoordinator:MainBarCoordinator) {
        super.init(nibName: nil, bundle: nil)
        
        self.tabBarCoordinator = barCoordinator
        self.setupViewControllers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    //MARK: private methods
    func setupViewControllers() {
        //home
       
        let homeViewController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        homeViewController.homeViewModel = ProfileViewModel()
        
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: homeViewController, relatedCoordinator: nil, relatedViewModel: nil)
        
        //search
        let userSearchVC = SearchUsersViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let searchNavController = UINavigationController(rootViewController: userSearchVC)
        searchNavController.tabBarItem.image = #imageLiteral(resourceName: "search_unselected")
        searchNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "search_selected")
        
        let searchUsersCoordinator = SearchUsersCoordinator()
//        userSearchVC.delegate = searchUsersCoordinator
        userSearchVC.userSearchControllerCoordinator = searchUsersCoordinator
        searchUsersCoordinator.rootViewController = searchNavController
        

        //Photos
        let photoSelectionVC = PhotoSelectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let photoSelectionNavigationController = UINavigationController(rootViewController: photoSelectionVC)
        let photoSelectionCoordinator = PhotoSelectionCoordinator(photoSelectionCoordDelegate: self, rootViewController: photoSelectionNavigationController, childCoordinators: [])
        photoSelectionVC.coordinator = photoSelectionCoordinator
        
        photoSelectionNavigationController.tabBarItem.image = #imageLiteral(resourceName: "plus_unselected")
        photoSelectionNavigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "plus_unselected")

        
        //like
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), relatedCoordinator: nil, relatedViewModel:nil)
        
        //user profile
        guard let loggedInUser = AuthComponent.getLoggedInUserData() else{
            print("What a terrible error !!!")
            return
        }
        let profileCoordinator = ProfileCoordinator(with: self)
        profileCoordinator.profileCoordinatorDelegate = self.tabBarCoordinator
        
        let profileViewModel = ProfileViewModel()
        profileViewModel.userId = loggedInUser.id!
        
        let profileViewController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        profileViewController.profileViewModel = profileViewModel
        profileViewController.profileCoordinator = profileCoordinator
        
    
        let userProfileNavController = UINavigationController(rootViewController: profileViewController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           photoSelectionNavigationController,
                           likeNavController,
                           userProfileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController(), relatedCoordinator coord: Coordinator?, relatedViewModel viewModel:InstagramBaseViewModel?) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }

    
}


extension InstagtamMainBarController:PhotoSelectionCoordinatorDelegate{
    func didFinishPostingImage() {
        print ("Wil  switch finally")
        self.selectedIndex = 0
    }
    
    
}


