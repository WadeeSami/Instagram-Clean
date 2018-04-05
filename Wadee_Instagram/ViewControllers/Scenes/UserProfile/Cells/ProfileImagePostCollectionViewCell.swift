//
//  ProfileImagePostCollectionViewCell.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/30/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import SnapKit
class ProfilePostCollectionViewCell:UICollectionViewCell{
    static let PROFILE_COLLECTION_VIEW_CELL_ID = "ProfileImageCollectionViewCell"
    let userProfileImageView : UIImageView = {
        let profileImage = UIImageView()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius =  40
        profileImage.backgroundColor = UIColor.blue
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCellUI(){
        let profilePostImage = userProfileImageView
        self.contentView.addSubview(profilePostImage)
        profilePostImage.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
    }

    
}
