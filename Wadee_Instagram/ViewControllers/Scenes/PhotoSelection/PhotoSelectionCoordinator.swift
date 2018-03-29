//
//  PhotoSelectionCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 3/9/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
protocol PhotoSelectionCoordinatorDelegate:class {
    func didFinishPostingImage()
}

struct PhotoSelectionCoordinator:Coordinator{
    weak var photoSelectionCoordDelegate:PhotoSelectionCoordinatorDelegate?
    
    var rootViewController: UINavigationController
    func start() {
        //
    }
    
    var childCoordinators: [Coordinator] = []
    
    func addChildCoordinator(coordinator: Coordinator) {
        //
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        //
    }
    
    
}

extension PhotoSelectionCoordinator{
    func openPhotoShareViewController(withImage image:UIImage){
        let photoSharingViewController = PhotoSharingViewController(nibName: nil, bundle: nil)
        photoSharingViewController.coordinator = self
        photoSharingViewController.sharedImage = image
        self.rootViewController.show(photoSharingViewController, sender: self)
    }
    
}

extension PhotoSelectionCoordinator{
    func didFinishPostingImage(fromPhotoSharingViewController sharingController:PhotoSharingViewController){
        self.rootViewController.popViewController(animated: true)
        photoSelectionCoordDelegate?.didFinishPostingImage()
        
    }
}








