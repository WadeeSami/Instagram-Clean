//
//  SplashViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/16/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()
    }
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.activityIndicator.stopAnimating()
            
            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                // navigate to protected page
            } else {
                // navigate to login screen
                AppDelegate.shared.rootViewController.switchToLogout()
            }
        }
    }
}
