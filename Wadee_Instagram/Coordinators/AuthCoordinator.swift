//
//  LoginInCoordinator.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/19/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

protocol AuthCoordinatorDelegate{
    func userDidAuthenticate()
}

class AuthCoordinator :NSObject, Coordinator{
    //MARK: delegate
    var authCoordinatorDelegate:AuthCoordinatorDelegate?
    // MARK :- API
    var childCoordinators: [Coordinator] = []
    
    func addChildCoordinator(coordinator: Coordinator) {
        print ("add")
    }
    
    func removeChildCoordinator(coordinator: Coordinator) {
        print ("remove")
    }
    
    func start() {
        self.navigationController?.show(self.loginViewController, sender: self)
    }
    
    func showImagePicker(){
        self.showImagePickerForSignup()
    }
    
    // MARK :- private memebers
    
    fileprivate var navigationController : UINavigationController?
    fileprivate var loginViewController : LoginViewController!
    fileprivate var signupViewController: SignupViewController?
   // weak var delegate : AuthCoordinatorDelegate?
    
    // MARK :- initializer
    init(with navigationControoler:UINavigationController) {
        super.init()
        self.navigationController = navigationControoler
        let loginViewModel = LoginViewModel()
        loginViewModel.loginCoordinatorDelegate = self
        self.loginViewController = LoginViewController(with: loginViewModel)
    }
}


extension AuthCoordinator: LoginViewModelCoordinatorDelegate{
    func userDidLogin() {
        //go to profile
        print("Heading Directry to the profile")
        self.authCoordinatorDelegate?.userDidAuthenticate()
    }
    
    func userDidChooseSignup() {
        var signupViewModel = SignupViewModel()
        signupViewModel.signupCoordinatorDelegate = self
        self.signupViewController = SignupViewController(withViewModel: signupViewModel, andCoordinator: self)
        self.navigationController?.show(self.signupViewController!, sender: self)
    }
}

extension AuthCoordinator: SignupViewModelCoordinatorDelegate{
    func userDidSignUp() {
        print ("User Finished Sign up Successfullt, go to profile page")
    }
    
    func userChoseLogin() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AuthCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //do nothing
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //send the info to the
        var selectedImage: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = originalImage
        }
        self.signupViewController?.selectedProfileImage = selectedImage!
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func showImagePickerForSignup(){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }
}
