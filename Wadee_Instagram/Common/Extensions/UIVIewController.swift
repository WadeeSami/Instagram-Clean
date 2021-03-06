//
//  UIViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/23/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

extension UIViewController{
     func displayValidationErrorAlert(forError errorType:InstagramErrorType){
        let alertController = UIAlertController(title: "Error", message: errorType.relatedMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


//extension UIViewController{
//    var viewModel : InstagramBaseViewModel{
//        set{
//            DispatchQueue.main.async {
//                self.viewModel = newValue
//            }
//
//        }
//        get{
//            return self.viewModel
//        }
//    }
//
//    var coordinator : Coordinator{
//        set{
//            DispatchQueue.main.async {
//                self.coordinator = newValue
//            }
//
//        }
//        get{
//            print("Getting Coord")
//            return self.coordinator
//        }
//    }
//}

