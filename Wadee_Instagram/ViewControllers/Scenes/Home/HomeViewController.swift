//
//  HomeViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/8/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class HomeViewController:UICollectionViewController{
    var homeViewModel: ProfileViewModel?
    var homeCoordinator: ProfileCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.HOME_VC_CELL_ID)
        setupNavBar()
        self.collectionView?.backgroundColor = UIColor.white
        self.setupRefreshControl()
        homeViewModel?.reloadPostsCollectionViewClosure = { [weak self] in
            self?.collectionView?.refreshControl?.endRefreshing()
            self?.collectionView?.reloadData()
            SVProgressHUD.dismiss()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show()
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
        height += 50
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
        }else{
            cell.profileImage.setImageFrom(name: self.homeViewModel?.postsList[indexPath.row].postUser?.username, width: 50, height: 50)
        }
        return cell
    }
    
    
}

extension HomeViewController{
    @objc func handleRefreshControl(){
        self.homeViewModel?.fetchUserPosts()
    }
    
    private func setupRefreshControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        self.collectionView?.refreshControl = refreshControl
    }
}

