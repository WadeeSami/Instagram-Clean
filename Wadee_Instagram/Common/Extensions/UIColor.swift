//
//  UIColor.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/19/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: Double, green:Double, blue:Double, alpha:Double)->UIColor{
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: CGFloat(alpha))
    }
}
