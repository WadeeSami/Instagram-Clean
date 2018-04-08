//
//  HomeViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/8/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
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
        return CGSize(width: self.view.frame.width, height: 390)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.HOME_VC_CELL_ID, for: indexPath) as! HomeCollectionViewCell
        cell.nameLabel.text = "wadee"
        
        if let post_media = self.homeViewModel?.postsList[indexPath.row].mediaObjects![0], let imageUrl = URL(string: post_media.href_original){
            
            URLSession.shared.dataTask(with: imageUrl){ (data, response, error ) in
                guard let imageData = data else {return}
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.cellImageView.image = image
                    cell.profileImage.image = image
                }
                }.resume()
        
        }
        return cell
    }
    
}

//extension ProfileViewController{
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileCollectionViewHeaderCell.COLLECTION_VIEW_HEADER_CELL_ID, for: indexPath)
//
//        return headerCell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 200)
//    }
//}
//
//
//
//
//
//
//
