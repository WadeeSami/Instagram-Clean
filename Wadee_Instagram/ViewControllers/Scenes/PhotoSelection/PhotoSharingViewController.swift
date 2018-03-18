//
//  PhotoSharingController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/18/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import SnapKit

class PhotoSharingViewController:UIViewController{
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupViews()
    }
    
    //MARK: views
    public var sharedImage:UIImage?{
        didSet{
            self.sharedImageView.image = sharedImage
        }
    }
    
    private var sharedImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var textView : UITextView = {
       let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        
        return textView
    }()
    
    //MARK: private methods
    private func setupNavigationBar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareImage))
    }
    private func setupViews(){
        self.setupNavigationBar()
        
        self.view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240, alpha: 1)
        
        let container = UIView()
        self.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.white
        container.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(4)
            make.height.equalTo(100)
        }
        
        
        container.addSubview(sharedImageView)
        sharedImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(container).offset(8)
            make.bottom.equalTo(container).offset(-8)
            make.height.width.equalTo(80)
        }
        
        container.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(container).offset(8)
            make.right.bottom.equalTo(container).offset(-8)
            make.left.equalTo(sharedImageView.snp.right)
            make.height.equalTo(60)
        }
    }
    
    
    //MARK: handlers
    @objc private func shareImage(){
        
    }
    
}
