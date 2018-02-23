//
//  SignupViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/22/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class SignupViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //MARK: private vars
    private var viewModel:SignupViewModel?
    private var coordinator:AuthCoordinator?
    //MARK: LifCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: initialozers
    init(withViewModel viewModel:SignupViewModel,andCoordinator coordinator:AuthCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public vars
    var selectedProfileImage:UIImage?{
        didSet{
            plusButton.layer.cornerRadius = plusButton.frame.width/2
            plusButton.layer.borderColor = UIColor.black.cgColor
            plusButton.layer.borderWidth = 3.0
            plusButton.clipsToBounds = true
            plusButton.setImage(selectedProfileImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        }
    }
    
//    var na
    
    //MARK: UI Components
    let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        
        btn.addTarget(self, action: #selector(addProfileButton), for: .touchUpInside)
        return btn
    }()
    
    let emailTextField :UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleEmailChange), for: .editingChanged)
        return textfield
    }()
    
    let usernameTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Username"
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleUsernameChange), for: .editingChanged)
        return textfield
    }()
    
    let passwordTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handlePasswordChange), for: .editingChanged)
        return textfield
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 148, green: 204, blue: 244, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    let signinButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Already have an account, ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        let complementaryTitle = NSAttributedString(string: "Sign In", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237, alpha: 1.0)])
        btnTitle.append(complementaryTitle)
        let button = UIButton()
        button.setAttributedTitle(btnTitle, for: .normal)
        button.addTarget(self, action: #selector(handleSignin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.width.equalTo(140)
            make.height.equalTo(140)
            make.centerX.equalTo(view).offset(0)
        }
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        
        stackView.backgroundColor = UIColor.green
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (stackView) in
            stackView.top.equalTo(plusButton.snp.bottom).offset(20)
            stackView.left.equalTo(view).offset(40)
            stackView.right.equalTo(view).offset(-40)
            stackView.height.equalTo(200)
        }
        
        view.addSubview(signinButton)
        signinButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    
    @objc func handleSignup(){
        guard allFieldsNotEmpty() else{
            return
        }
        
        do{
            try self.viewModel?.signup()
        }catch let error{
            if let validError = error as? InstagramErrorType{
                self.displayValidationErrorAlert(forError: validError)
            }else{
                print ("Some weird error")
            }
        }
    }
    
    @objc func handlePasswordChange(){
        self.viewModel?.password = self.passwordTextField.text
    }
    
    @objc func handleEmailChange(){
            self.viewModel?.email = self.emailTextField.text
    }
    
    @objc func handleUsernameChange(){
        self.viewModel?.username = self.usernameTextField.text
    }
    
    @objc func addProfileButton(){
        self.coordinator?.showImagePicker()
    }
    
    @objc func handleSignin(){
        self.viewModel?.goToLogin()
    }
    
    private func allFieldsNotEmpty()->Bool{
        return self.view.validateAllTextFieldsNotEmpty() && self.selectedProfileImage != nil
    }
    
}
