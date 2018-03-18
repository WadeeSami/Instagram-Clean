//
//  PhotoSelectionHeaderCell.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/18/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class PhotoSelectionHeaderCell: UICollectionViewCell{
    let cellImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.cyan
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.cyan
        self.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { (elm) in
            elm.left.right.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
