//
//  ProfileCollectionViewHeaderCel.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/26/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import SnapKit

class ProfileCollectionViewHeaderCell: UICollectionViewCell{
    static let COLLECTION_VIEW_HEADER_CELL_ID = "CollectionViewHeaderCell"
    let PROFILE_IMAGE_VIEW_WIDTH = 80
    
    var user : User?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupProfileImage()
        setupToolBar()
        setupUsernameLabel()
        setupUserInfoBarAndUpperSeparator()
        setupEditProfileBtn()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI Components
    let userProfileImageView : UIImageView = {
        let profileImage = UIImageView()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius =  40
        profileImage.backgroundColor = UIColor.blue
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    
    let gridButton : UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return btn
    }()
    
    let listButton : UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.1)
        return btn
    }()
    
    let ribbonButton : UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.1)
        return btn
    }()
    
    let usernameLabel : UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.textAlignment = .center
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        return usernameLabel
    }()
    
    let postsLabel : UILabel = {
        let label = UILabel()
        label.text = "0\nposts"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followersLabel : UILabel = {
        let label = UILabel()
        label.text = "0\nFollowers"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingLabel : UILabel = {
        let label = UILabel()
        label.text = "0\nFollowing"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let userInfoStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let editProfileBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.layer.borderWidth=1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: UI Setup Methods
    
    private func setupProfileImage(){
        self.addSubview(userProfileImageView)
        userProfileImageView.snp.makeConstraints { (profileImageview) in
            profileImageview.left.equalTo(self).offset(12)
            profileImageview.top.equalTo(self).offset(12)
            profileImageview.width.equalTo(PROFILE_IMAGE_VIEW_WIDTH)
            profileImageview.height.equalTo(PROFILE_IMAGE_VIEW_WIDTH)
        }
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "test"
        self.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(userProfileImageView.snp.centerX)
            make.top.equalTo(userProfileImageView.snp.bottom)
        }
        
    }
    
    private func fetchProfileImage(){
//        guard let userProfileImageUrl = self.user?.profileImageUrl else {return}
//        URLSession.shared.dataTask(with: userProfileImageUrl){ (data, response, error) in
//            guard let data = data else {return}
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                self.userProfileImageView.image = image
//            }
//            }.resume()
    }
    
    private func setupToolBar(){
        let toolbarStackView = UIStackView(arrangedSubviews: [gridButton, listButton, ribbonButton])
        toolbarStackView.axis = .horizontal
        toolbarStackView.alignment = .center
        toolbarStackView.distribution = .fillEqually
        toolbarStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(toolbarStackView)
        toolbarStackView.snp.makeConstraints { (stackView) in
            stackView.left.equalTo(self).offset(8)
            stackView.right.equalTo(self).offset(-8)
            stackView.bottom.equalTo(self)
            stackView.height.equalTo(80)
        }
        
        let lowerSeparator = UIView()
        lowerSeparator.backgroundColor = UIColor.lightGray
        addSubview(lowerSeparator)
        lowerSeparator.snp.makeConstraints { (sep) in
            sep.left.equalTo(self)
            sep.right.equalTo(self)
            sep.bottom.equalTo(toolbarStackView.snp.top)
            sep.height.equalTo(1)
        }
    }
    
    private func setupUsernameLabel(){
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (label) in
            label.top.equalTo(userProfileImageView.snp.bottom).offset(4)
            label.left.equalTo(self).offset(12)
        }
    }
    
    private func setupUserInfoBarAndUpperSeparator(){
        userInfoStackView.addArrangedSubview(postsLabel)
        userInfoStackView.addArrangedSubview(followersLabel)
        userInfoStackView.addArrangedSubview(followingLabel)
        addSubview(userInfoStackView)
        userInfoStackView.snp.makeConstraints({ (make) in
            make.top.equalTo(self)
            make.left.equalTo(userProfileImageView.snp.right).offset(12)
            make.right.equalTo(self).offset(4)
            make.height.equalTo(50)
        })
        
        let upperSeparator = UIView()
        upperSeparator.backgroundColor = UIColor.lightGray
        addSubview(upperSeparator)
        upperSeparator.snp.makeConstraints { (sep) in
            sep.left.equalTo(self)
            sep.right.equalTo(self)
            sep.top.equalTo(self)
            sep.height.equalTo(1)
        }
    }
    
    private func setupEditProfileBtn(){
        addSubview(editProfileBtn)
        editProfileBtn.snp.makeConstraints { (btn) in
            btn.top.equalTo(userInfoStackView.snp.bottom).offset(4)
            btn.left.equalTo(userProfileImageView.snp.right).offset(8)
            btn.right.equalTo(self).offset(-4)
            btn.height.equalTo(34)
        }
        
    }
}
