//
//  UIImageView.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 4/12/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
extension UIImageView{
    
    public func fetchImageFromURL(imageUrl:URL){
        URLSession.shared.dataTask(with: imageUrl){ (data, response, error ) in
            guard let imageData = data else {return}
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }


    public func setImageFrom(name: String?, width:CGFloat, height:CGFloat) -> UIImage? {
    let frame = CGRect(x: 0, y: 0, width: width, height: height)
    let nameLabel = UILabel(frame: frame)
    nameLabel.textAlignment = .center
    nameLabel.backgroundColor = .lightGray
    nameLabel.textColor = .white
    nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
    var initials = ""
    if let initialsArray = name?.components(separatedBy: " ") {
        if let firstWord = initialsArray.first {
            if let firstLetter = firstWord.first {
                initials += String(firstLetter).capitalized
            }
        }
        if initialsArray.count > 1, let lastWord = initialsArray.last {
            if let lastLetter = lastWord.first {
                initials += String(lastLetter).capitalized
            }
        }
    } else {
        return nil
    }
    nameLabel.text = initials
    UIGraphicsBeginImageContext(frame.size)
    if let currentContext = UIGraphicsGetCurrentContext() {
        nameLabel.layer.render(in: currentContext)
        let nameImage = UIGraphicsGetImageFromCurrentImageContext()
        self.image = nameImage
        return nameImage
    }
    return nil
}

}
