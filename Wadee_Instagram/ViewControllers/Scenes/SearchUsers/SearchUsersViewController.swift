//
//  SearchUsersViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/12/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import SnapKit


class SearchUsersViewController:UICollectionViewController{
    
    var userSearchControllerCoordinator:SearchUsersCoordinator?
    fileprivate var searchUsersCoordinator: SearchUsersCoordinator?
    private var userObjectsList = [User]()
    // pragma MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUsers()
        searchBar.isHidden = false
    }
    
    func fetchUsers(){
        UserComponent.searchUsersWith(searchTerm: "", successHandler: {users in
            self.userObjectsList = users
            self.collectionView?.reloadData()
        }, failureHandler: {
            print ("shoot")
        })
    }
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Users"
        searchBar.barTintColor = UIColor.rgb(red: 230, green: 230, blue: 230, alpha: 1)
        return searchBar
    }()
    
    func setupUI(){
        self.collectionView?.register(SearchUsersCollectionViewControllerCell.self, forCellWithReuseIdentifier: SearchUsersCollectionViewControllerCell.SEARCH_USER_COLLECTION_VIEW_CELL_ID)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.alwaysBounceVertical = true
        let navBar = self.navigationController?.navigationBar
        navBar?.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(navBar!).offset(8)
            make.right.equalTo(navBar!).offset(-8)
            make.top.bottom.equalTo(navBar!)
        }
    }
}


extension SearchUsersViewController: UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userObjectsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchUsersCollectionViewControllerCell.SEARCH_USER_COLLECTION_VIEW_CELL_ID, for: indexPath) as! SearchUsersCollectionViewControllerCell
        
        cell.user = self.userObjectsList[indexPath.row]
        
        return cell
    }
    
}

extension SearchUsersViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        self.userSearchControllerCoordinator?.userTabClicked(userId: self.userObjectsList[indexPath.row].id!)
    }
}
