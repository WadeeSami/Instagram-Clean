//
//  ProfileViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/24/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController:UICollectionViewController{
    static let profileImagesCellID = "ProfilePicturesCellId"
    //MARK: properties
    var profileViewModel:ProfileViewModel?
    var profileCoordinator: ProfileCoordinator?
    
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupNavigationBar()
        self.view.backgroundColor = UIColor.white
        self.collectionView?.backgroundColor = UIColor.white
        
        //register cells
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ProfileViewController.profileImagesCellID)
        self.collectionView?.register(ProfilePostCollectionViewCell.self, forCellWithReuseIdentifier: ProfilePostCollectionViewCell.PROFILE_COLLECTION_VIEW_CELL_ID)
        self.collectionView?.register(ProfileCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProfileCollectionViewHeaderCell.COLLECTION_VIEW_HEADER_CELL_ID)
        
        profileViewModel?.reloadPostsCollectionViewClosure = { [weak self] in
            self?.collectionView?.reloadData()
        }
        profileViewModel?.fetchUserPosts()
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
        
        self.profileCoordinator?.logout()
        
    }
}
extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.profileViewModel?.postsList.count)!
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostCollectionViewCell.PROFILE_COLLECTION_VIEW_CELL_ID, for: indexPath) as? ProfilePostCollectionViewCell
//        cell?.userProfileImageView.af_setImage(withURL: <#T##URL#>)
        if let post_media = self.profileViewModel?.postsList[indexPath.row].mediaObjects![0], let imageUrl = URL(string: post_media.href_original){
                cell?.userProfileImageView.af_setImage(withURL: imageUrl)
                
        }
        
        
        return cell!
    }
    
}

extension ProfileViewController{
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileCollectionViewHeaderCell.COLLECTION_VIEW_HEADER_CELL_ID, for: indexPath)
        
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}






