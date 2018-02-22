//
//  UIView.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
extension UIView{
    func shakeView(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
    
    func validateAllTextFieldsNotEmpty()->Bool{
        var allValid = true
        let allViews = self.subviews
        if let current = self as? UITextField {
            if (current.text?.isEmpty)!{
                current.shakeView()
                return false
            }
            return true
        }
        if allViews.count != 0 {
            for subView in allViews{
                let subViewValid = subView.validateAllTextFieldsNotEmpty()
                allValid = allValid && subViewValid
            }
        }
        
        return allValid
    }
    
}
