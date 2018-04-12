//
//  SearchUsersViewControllerCell.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/12/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import SnapKit
class SearchUsersCollectionViewControllerCell:UICollectionViewCell{
    public var user:User?{
        didSet{
            self.configureCellWithUserInfo(user: user!)
        }
    }
    
    static let SEARCH_USER_COLLECTION_VIEW_CELL_ID = "SEARCH_USER_COLLECTION_VIEW_CELL_ID"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userProfileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI(){
        self.addSubview(userProfileImage)
        userProfileImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(5)
            make.width.height.equalTo(50)
        }
        
        self.addSubview(usernameLabel)
        usernameLabel.text = "wadee sami"
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userProfileImage.snp.right).offset(4)
            make.right.equalTo(self).offset(-4)
            make.top.bottom.equalTo(self)
        }
    }

    private func configureCellWithUserInfo(user:User){
        self.usernameLabel.text = user.username
        if let userMedia = user.userMedia{
            self.userProfileImage.fetchImageFromURL(imageUrl: URL(string: (user.userMedia?.href_small)!)!)
        }else{
            self.userProfileImage.setImageFrom(name: self.user?.username, width: 50, height: 50)
        }
        
    }
}
