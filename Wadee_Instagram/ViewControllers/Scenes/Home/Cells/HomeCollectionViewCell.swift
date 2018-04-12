//
//  HomeCollectionViewCell.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/8/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import SnapKit

class HomeCollectionViewCell:UICollectionViewCell{
    static let HOME_VC_CELL_ID = "home_controller_cell_id"
    let cellImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.red
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25.0
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let optionsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("•••", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    let likeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let commentBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let shareBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let bookmarkBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let captionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "this is a text\t hello again \n\n 2 weeks ago"
        return label
    }()
    
    func setupStackView()-> UIStackView{
        let stackView = UIStackView(arrangedSubviews: [likeBtn, commentBtn, shareBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(5)
            make.width.height.equalTo(50)
        }
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImage.snp.centerY)
            make.left.equalTo(profileImage.snp.right)
            
        }
        
        self.addSubview(optionsButton)
        optionsButton.snp.makeConstraints { (make) in
            make.right.top.equalTo(self).offset(-5)
            make.centerY.equalTo(profileImage.snp.centerY)
            
        }
        
        self.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { (elm) in
            elm.left.right.equalTo(self)
            elm.top.equalTo(profileImage.snp.bottom).offset(5)
            elm.height.equalTo(self.snp.width).multipliedBy(1)
        }
        
        let stackView = setupStackView()
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(cellImageView.snp.bottom)
            make.height.equalTo(50)
            make.left.equalTo(self)
            make.width.equalTo(120)
        }
        
        self.addSubview(bookmarkBtn)
        bookmarkBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-5)
            make.centerY.equalTo(stackView.snp.centerY)
        }
        
        self.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(stackView.snp.bottom)
            make.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func fetchPostImageFromUrl(imageURL: URL){
        self.cellImageView.fetchImageFromURL(imageUrl: imageURL)

    }
}
