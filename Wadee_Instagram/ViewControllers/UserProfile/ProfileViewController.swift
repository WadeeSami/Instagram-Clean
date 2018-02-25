//
//  ProfileViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/24/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class ProfileViewController:UICollectionViewController{
    static let profileImagesCellID = "ProfilePicturesCellId"
    //MARK: properties
    var viewModel:ProfileViewModel?
    var coordinator: Coordinator?
    
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupNavigationBar()
        self.view.backgroundColor = UIColor.white
        self.collectionView?.backgroundColor = UIColor.white
        
        //register cellr
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ProfileViewController.profileImagesCellID)
    }
    
    //MARK: initializer
    
    
    //MARK: private methods
    private func setupNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "User Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style: .plain, target: self, action: #selector(handleProfilePageOptions))
    }
    
    //MARK: handlers and selectors
    @objc func handleProfilePageOptions(){
        let actionSheet  = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Log out", style: .destructive, handler: { (_)in
            self.logout()
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        actionSheet.addAction(logoutAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
        
    }
    
     func logout(){
        print ("logout")
    }
}
extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/3 - 2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileViewController.profileImagesCellID, for: indexPath)
        print ("What the hell is going on !!!")
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
}
