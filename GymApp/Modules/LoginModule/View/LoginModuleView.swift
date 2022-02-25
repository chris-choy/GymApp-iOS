//
//  LoginModuleView.swift
//  GymApp
//
//  Created by Chris on 2021/5/23.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit
import Lottie

class LoginModuleView: UIViewController, UITextFieldDelegate {
    
    var presenter: LoginModulePresenterProtocol?
    
    let loadingAnimationView = LoadingAnimationView()
    
    var registerView: RegisterViewProtocols?
    
    let usernameTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "用户名"
        tf.backgroundColor = UIColor(named: "TextFieldBackground")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let passwordTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "密码"
        tf.backgroundColor = UIColor(named: "TextFieldBackground")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let signInButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("登陆", for: .normal)
        
        btn.backgroundColor = UIColor(named: "ButtonBackground")
        btn.setTitleColor(.white, for: .normal)
        
        
        btn.layer.cornerRadius = 10
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", for: .normal)
        
        btn.backgroundColor = UIColor(named: "ButtonBackground")
        btn.setTitleColor(.white, for: .normal)
        
        btn.layer.cornerRadius = 10
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    func getHighResolutionAppIconName() -> String? {
        guard let infoPlist = Bundle.main.infoDictionary else { return nil }
        guard let bundleIcons = infoPlist["CFBundleIcons"] as? NSDictionary else { return nil }
        guard let bundlePrimaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? NSDictionary else { return nil }
        guard let bundleIconFiles = bundlePrimaryIcon["CFBundleIconFiles"] as? NSArray else { return nil }
        guard let appIcon = bundleIconFiles.lastObject as? String else { return nil }
        return appIcon
    }
    
    fileprivate func setupLoadingAnimationView() {
        view.addSubview(loadingAnimationView)
        
        loadingAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set View.
        view.backgroundColor = .white
        
        // test setting.
//        usernameTF.layer.borderWidth = 1
//        passwordTF.layer.borderWidth = 1
//        signInButton.layer.borderWidth = 1
//        signUpButton.layer.borderWidth = 1
//        stackView.layer.borderWidth = 1
//        logoImageView.layer.borderWidth = 1
        // test setting end.
        
        setupViews()
        setupLoadingAnimationView()
        
        // Test
        usernameTF.text = "user1"
        passwordTF.text = "password1"
        handleSignIn()
        // Test end.
        
    }
    
    func setupViews(){
        view.addSubview(stackView)
        view.addSubview(logoImageView)

        // Add the view into stack view.
        stackView.addArrangedSubview(usernameTF)
        stackView.addArrangedSubview(passwordTF)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(signUpButton)
        
        // Text Field.
        NSLayoutConstraint.activate([
            usernameTF.heightAnchor.constraint(equalToConstant: 40),
            passwordTF.heightAnchor.constraint(equalToConstant: 40),
        ])
        usernameTF.layer.cornerRadius = 10
        passwordTF.layer.cornerRadius = 10
        
        usernameTF.delegate = self
        passwordTF.delegate = self

        usernameTF.setLeftPaddingPoints(10)
        passwordTF.setLeftPaddingPoints(10)
        usernameTF.setRightPaddingPoints(10)
        passwordTF.setRightPaddingPoints(10)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        passwordTF.isSecureTextEntry = true
        
        // Logo imageView.
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        if let name = getHighResolutionAppIconName() {
            logoImageView.image = UIImage(named: name)
        }
        
        // Stack view setting.
        stackView.spacing = 20
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
        
        // Sign in button.
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
        
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
    }
    
    @objc func handleSignIn(){
        
        guard usernameTF.text?.isEmpty == false else {
            self.present(AlertController.showConfirmOnlyAlert(title: "提示", message: "请输入用户名。", action: nil), animated: true, completion: nil)
            return
        }
        
        guard passwordTF.text?.isEmpty == false else {
            self.present(AlertController.showConfirmOnlyAlert(title: "提示", message: "请输入密码。", action: nil), animated: true, completion: nil)
            return
        }
        
        // 1. Get usernmae and password.
        if let username = usernameTF.text,
           let password = passwordTF.text{
            
            loadingAnimationView.show()
            presenter?.handleSignIn(username: username, password: password)
        }
        
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleSignUp(){
        
        let registerVC = RegisterViewController(loginView: self)
        registerView = registerVC
                
        navigationController?.pushViewController(registerVC, animated: true)

    }
    
    @objc func dismissKeyboard() {
        usernameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    @objc func showMainViewController(){
        loadingAnimationView.hide()
        if let keyWindow =
            UIApplication.shared.keyWindow{
            
            self.dismiss(animated: true, completion: nil)
            
            keyWindow.rootViewController = BottomTabBarController()
        }
    }
    
}

extension LoginModuleView: LoginModuleViewProtocol {
    func showSignUpSuccess() {
        registerView?.showSignUpSuccess()
    }
    
    func showSignUpFailed(message: String){
        registerView?.showSignUpFailed(message: message)
    }
    
    func showSignInErrorAlert(message: String) {
        loadingAnimationView.hide()
        present(AlertController.showConfirmCancelAlert(title: "提示", message: message),
                animated: true, completion: nil)
    }
    
    func navigationTo(vc: UIViewController) {
        
        if let keyWindow =
            UIApplication.shared.keyWindow{
            
            self.dismiss(animated: true, completion: nil)
            
            keyWindow.rootViewController = BottomTabBarController()
        }
        
    }
    
}

extension UITextField{
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setBottomBorder() {
            self.borderStyle = .none
        
            self.layer.backgroundColor = UIColor.white.cgColor
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
        }
    
}

extension LoginModuleView: ForRegisterView{
    
    func signUp(user: User) {
        self.presenter?.signUp(user: user)
    }
    
}

protocol ForRegisterView {
    
    func signUp(user : User)
    
}
