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
    var profileControllerMode:ProfileViewControllerMode = ProfileViewControllerMode.USER_HOME_PAGE
    
    var user : User?
    private var headerCellViewModel: ProfileViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupProfileImage()
        setupToolBar()
        setupUsernameLabel()
        setupUserInfoBarAndUpperSeparator()
        setupEditProfileBtn()
        
        editProfileBtn.addTarget(self, action: #selector(handleMainButton), for: .touchUpInside)
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
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237, alpha: 1)
        btn.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        return btn
    }()
    
    
    
    //MARK: config method
    public func configure(withViewModel viewModel: ProfileViewModel){
        self.headerCellViewModel = viewModel
       
        self.headerCellViewModel.getUserInfo{ user in
            self.user = user
            self.usernameLabel.text = self.user?.username
            if let smallImageUrlString = self.user?.userMedia?.href_small , let imageUrl = URL(string: smallImageUrlString) {
                self.userProfileImageView.fetchImageFromURL(imageUrl: imageUrl)
            }
            self.userProfileImageView.setImageFrom(name: self.user?.username, width: CGFloat(self.PROFILE_IMAGE_VIEW_WIDTH), height: CGFloat(self.PROFILE_IMAGE_VIEW_WIDTH))
            
            self.postsLabel.text = "\(self.headerCellViewModel.postsList.count)\n posts"
            var editProfileTitle = "Edit Profile"
            if self.profileControllerMode == ProfileViewControllerMode.DISPLAY_PROFILE_PAGE{
                if (self.user?.in_fellowship)!{
                    editProfileTitle = "UnFollow"
                }else{
                    editProfileTitle = "Follow"
                }
            }
            self.editProfileBtn.setTitle(editProfileTitle, for: .normal)
        }
        
    }
    
    //MARK: UI Setup Methods
    
    private func setupProfileImage(){
        self.addSubview(userProfileImageView)
        userProfileImageView.snp.makeConstraints { (profileImageview) in
            profileImageview.left.equalTo(self).offset(12)
            profileImageview.top.equalTo(self).offset(12)
            profileImageview.width.equalTo(PROFILE_IMAGE_VIEW_WIDTH)
            profileImageview.height.equalTo(PROFILE_IMAGE_VIEW_WIDTH)
        }
        
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
    
    @objc func handleMainButton(){
        if self.profileControllerMode == ProfileViewControllerMode.DISPLAY_PROFILE_PAGE{
            if (self.user?.in_fellowship)!{
                //unfollow
                print("unfollow")
                UserFelloshipComponent.unfollowUser(withUserId: (self.user?.id)!, successHandler: {
                    print ("unfollowd successfully")
                    self.editProfileBtn.setTitle("Follow", for: .normal)
                    self.user?.in_fellowship = false
                    }, failureHandler: {
                        print ("couln not complete successfully")
                        
                })
            }else{
                UserFelloshipComponent.followUser(withUserId: (self.user?.id)!, successHandler: {
                    print ("followed successfully")
                    self.editProfileBtn.setTitle("Unfollow", for: .normal)
                    self.user?.in_fellowship = true
                    }, failureHandler: {
                        print ("coulnd complete fellow ship")
                })
            }
        }else{
            //do something in edit profile
        }
    }
}
