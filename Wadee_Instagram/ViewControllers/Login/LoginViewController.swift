//
//  LoginViewController.swift
//  Wadee_Instagram
//
//  Created by Wadee Sami on 2/19/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController:UIViewController{
    // MARK : ViewModel
    fileprivate var viewModel :LoginViewModel?
    
    // MARK : initializers
    init(with loginViewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = loginViewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK :- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    
    
    //MARK :- UI Memebers
    let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        
        return btn
    }()
    
    let emailTextField :UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let usernameTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Username"
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let passwordTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 148, green: 204, blue: 244, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    let signinButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Already have an account, ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        let complementaryTitle = NSAttributedString(string: "Sign In", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237, alpha: 1.0)])
        btnTitle.append(complementaryTitle)
        let button = UIButton()
        button.setAttributedTitle(btnTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupUI(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
}
