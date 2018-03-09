//
//  InstagtamMainBarController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/9/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class InstagtamMainBarController:UITabBarController{
    
    //MARK: private vars
    fileprivate var tabBarCoordinator: MainBarCoordinator?
    
    //MARK: initializers
    init(with barCoordinator:MainBarCoordinator) {
        super.init(nibName: nil, bundle: nil)
        
//        self.tabBarCoordinator = barCoordinator
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
        let profileCoordinator = ProfileCoordinator(with: self)
        profileCoordinator.profileCoordinatorDelegate = self.tabBarCoordinator
        
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        profileViewController.profileViewModel = profileViewModel
        profileViewController.profileCoordinator = profileCoordinator
        
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout()), relatedCoordinator: nil, relatedViewModel: nil)
        
        //search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), relatedCoordinator: nil, relatedViewModel: nil)
        
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), relatedCoordinator: nil, relatedViewModel: nil)
        
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), relatedCoordinator: nil, relatedViewModel:nil)
        
        //user profile
        let userProfileController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController,
                           searchNavController,
                           plusNavController,
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
        if let viewModel = viewModel{
            navController.viewModel = viewModel
        }
        
        if let coord = coord{
            navController.coordinator = coord
        }
        
        return navController
    }

    
}


