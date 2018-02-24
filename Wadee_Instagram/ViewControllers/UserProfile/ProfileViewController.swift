//
//  ProfileViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/24/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class ProfileViewController:UIViewController{
    
    //MARK: properties
    var viewModel:ProfileViewModel?
    var coordinator: Coordinator?
    
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupNavigation()
    }
    
    //MARK: initializer
    
    
    //MARK: private methods
    private func setupNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "User Profile"
    }
    
}

extension ProfileViewController: UICollectionViewDelegate{
    
}

extension ProfileViewController:UICollectionViewDelegateFlowLayout{
    
}
