//
//  HomeViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/8/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController:UICollectionViewController{
    var homeViewModel: ProfileViewModel?
    var homeCoordinator: ProfileCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.HOME_VC_CELL_ID)
        setupNavBar()
        self.collectionView?.backgroundColor = UIColor.white
        
        homeViewModel?.reloadPostsCollectionViewClosure = { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.homeViewModel?.fetchUserPosts()
    }
    
    func setupNavBar(){
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.homeViewModel?.postsList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height :CGFloat = 50 + 8+8
        height += self.view.bounds.width
        height += 50
        height += 80
        return CGSize(width: self.view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.HOME_VC_CELL_ID, for: indexPath) as! HomeCollectionViewCell
        
        
        let postObject = self.homeViewModel?.postsList[indexPath.row]
        cell.nameLabel.text = postObject?.postUser?.username
        cell.captionLabel.text = postObject?.content
        if  (postObject?.mediaObjects?.count)! >= 1,let post_media = postObject?.mediaObjects![0], let imageUrl = URL(string: post_media.href_original){
            cell.fetchPostImageFromUrl(imageURL: imageUrl)
        
        }
    
        if let post_user_media = self.homeViewModel?.postsList[indexPath.row].postUser?.userMedia, let imageUrl = URL(string: post_user_media.href_small){
            cell.profileImage.fetchImageFromURL(imageUrl: imageUrl)
        }
        return cell
    }
    
}

