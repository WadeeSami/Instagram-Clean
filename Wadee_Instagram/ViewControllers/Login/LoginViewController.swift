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
    
    let signupButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Don't have an account, ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        let complementaryTitle = NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor: UIColor.blue])
        btnTitle.append(complementaryTitle)
        let button = UIButton()
        button.setAttributedTitle(btnTitle, for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logoView: UIView = {
        let logoView = UIView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white").withRenderingMode(.alwaysOriginal))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints({ (make) in
            make.center.equalTo(logoView)
        })
        return logoView
    }()
    
    let emailTextField :UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textfield
    }()
    
    let passwordTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textfield
    }()
    
    let signinButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 148, green: 204, blue: 244, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignin), for: .touchUpInside)
        return button
    }()
    @objc func handleSignup(){
        print ("goaaal")
    }
    
    
    private func setupStackView()-> UIStackView{
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signinButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(signupButton)
        signupButton.snp.makeConstraints { (btn) in
            btn.left.equalTo(self.view)
            btn.right.equalTo(self.view)
            btn.bottom.equalTo(self.view)
            btn.height.equalTo(50 )
        }
        
        self.view.addSubview(logoView)
        logoView.snp.makeConstraints { (view) in
            view.top.equalTo(self.view)
            view.left.equalTo(self.view)
            view.right.equalTo(self.view)
            view.height.equalTo(120)
        }
        logoView.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175, alpha: 1.0)
        let stackView = self.setupStackView()
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(40)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(140)
        }
    }
    
    
    
    @objc func handleTextChange(){
        let formValid = !(emailTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!
        
        if formValid {
            signinButton.isEnabled = true
            signinButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237, alpha: 1.0)
        }else{
            signinButton.isEnabled = false
            signinButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244, alpha: 1.0)
            
        }
    }
    
    @objc func handleSignin(){
     print ("please")
    }
}
