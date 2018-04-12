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
}
