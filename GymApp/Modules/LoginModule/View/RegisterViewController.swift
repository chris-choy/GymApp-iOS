//
//  RegisterViewController.swift
//  GymApp
//
//  Created by Chris on 2021/12/21.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit
import RoundedSwitch

class RegisterViewController: UIViewController {
    
    init(loginView: ForRegisterView) {
        self.loginView = loginView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let loginView : ForRegisterView
    
    let logoImage: UIImageView = {
        
        let iv = UIImageView()
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let usernameTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入用户名"
        tf.layer.cornerRadius = 10
        tf.setLeftPaddingPoints(10)
        
        tf.textContentType = .username
        
        tf.backgroundColor = UIColor(named: "TextFieldBackground")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let nameTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入昵称"
        tf.layer.cornerRadius = 10
        tf.setLeftPaddingPoints(10)
        
        tf.backgroundColor = UIColor(named: "TextFieldBackground")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let ageTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入年龄"
        tf.layer.cornerRadius = 10
        tf.setLeftPaddingPoints(10)
        tf.textContentType = .telephoneNumber
        
        tf.backgroundColor = UIColor(named: "TextFieldBackground")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    
    let genderSwitch: Switch = {
        
        let s = Switch()
        
        s.leftText = "男"
        s.rightText = "女"
        s.rightSelected = false
        s.tintColor = UIColor.purple
        s.disabledColor = s.tintColor.withAlphaComponent(0.15)
        s.backColor = s.tintColor.withAlphaComponent(0.05)
        s.sizeToFit()
        
        return s
        
    }()

    let passwordTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "请输入密码"
        tf.layer.cornerRadius = 10
        tf.setLeftPaddingPoints(10)
        tf.textContentType = .password
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        tf.backgroundColor = UIColor(named: "TextFieldBackground")
        
        return tf
    }()
    
    let commitButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("提交", for: .normal)
        btn.setTitleColor(UIColor(named: "CommitButtonTextColor"), for: .normal)
        btn.backgroundColor = UIColor(named: "ButtonBackground")
        
        btn.layer.cornerRadius = 10
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.alignment = .center
        
        return stack
    }()
    
    let loadingAnimationView = LoadingAnimationView()
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = true

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "注册"
        setupLogoImageView()
        setupStackView()
        commitButton.addTarget(self, action: #selector(commitAction), for: .touchUpInside)
        setupTextField()
        setupGesture()
        setupLoadingAnimationView()
        
        
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.scrollUp(notification:)),
               name: UIResponder.keyboardWillShowNotification,
               object: nil)
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.scrollDown(notification:)),
               name: UIResponder.keyboardWillHideNotification,
               object: nil)
        
        
        
        // Test
//        loadingAnimationView.show()
        // test
        
        
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    @objc func scrollDown(notification: NSNotification){

        self.view.frame.origin.y = 0
        
    }
    
    @objc func scrollUp(notification: NSNotification) {
        
        if( self.view.frame.origin.y == 0) {
            self.view.frame.origin.y -= 100
        }
        
   }

    
    func setupLogoImageView(){
        stackView.addArrangedSubview(logoImage)
        if let logoNamed = getHighResolutionAppIconName(){
            logoImage.image = UIImage(named: logoNamed)
        }
        stackView.setCustomSpacing(100, after: logoImage)
        
        logoImage.layer.cornerRadius = 10
    }
    
    func setupTextField(){
        
        usernameTF.delegate = self
        passwordTF.delegate = self
        nameTF.delegate     = self
        ageTF.delegate      = self
        
    }
    
    
    func setupGesture(){
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false //a
        
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func setupStackView(){
        
        stackView.addArrangedSubview(usernameTF)
        stackView.addArrangedSubview(passwordTF)
        stackView.addArrangedSubview(nameTF)
        stackView.addArrangedSubview(genderSwitch)
        stackView.addArrangedSubview(ageTF)
        stackView.addArrangedSubview(commitButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Width constraints.
        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            commitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            usernameTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            nameTF.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
            genderSwitch.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
            ageTF.widthAnchor.constraint(equalTo: usernameTF.widthAnchor),
            passwordTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
        ])
        
        // Height constraints.
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            commitButton.heightAnchor.constraint(equalToConstant: 40),
            usernameTF.heightAnchor.constraint(equalToConstant: 40),
            nameTF.heightAnchor.constraint(equalTo: usernameTF.heightAnchor),
            genderSwitch.heightAnchor.constraint(equalToConstant: 42),
            ageTF.heightAnchor.constraint(equalTo: usernameTF.heightAnchor),
            passwordTF.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // Spacing.
        stackView.spacing = 10
        stackView.setCustomSpacing(50, after: ageTF)
        
        
        
    }
    
    @objc func commitAction(){
        if let userName = usernameTF.text,
           let password = passwordTF.text,
           let name = nameTF.text,
           let ageText = ageTF.text{
            
            // 1. Check username.
            if(userName.isEmpty) {
                
                self.present(
                    AlertController.showConfirmOnlyAlert(
                        title: "提示",
                        message: "请输入用户名",
                        action: nil),
                    animated: true, completion: nil)
                
                return
                
            }
            
            // 2. Check password.
            if(password.isEmpty){
                self.present(AlertController.showConfirmCancelAlert(
                    title: "提示",
                    message: "请输入密码。"),
                    animated: true, completion: nil)
                return
            }

            // 3. Check name.
            if(name.isEmpty){
                self.present(AlertController.showConfirmCancelAlert(
                    title: "提示",
                    message: "请输入昵称。"),
                    animated: true, completion: nil)
                return
            }

            // 4. Check age.
            if(ageText.isEmpty){
                self.present(AlertController.showConfirmCancelAlert(
                    title: "提示",
                    message: "请输入年龄。"),
                    animated: true, completion: nil)
                return
            }
            
            guard let age = Int(ageText) else {
                self.present(AlertController.showConfirmCancelAlert(
                    title: "提示",
                    message: "请输入正确的年龄。"),
                    animated: true, completion: nil)
                return
            }
            
            
            
            // 5. Check gender.
            let isMale = !genderSwitch.rightSelected

            // 6. Commit to server.
            let user = User(id: 0, name: name, username: userName, age: age, gender: isMale, password: password)
            loadingAnimationView.show()
            loginView.signUp(user: user)

        } else {
            print("tf.ext null")
        }
        
    }
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func getHighResolutionAppIconName() -> String? {
        guard let infoPlist = Bundle.main.infoDictionary else { return nil }
        guard let bundleIcons = infoPlist["CFBundleIcons"] as? NSDictionary else { return nil }
        guard let bundlePrimaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? NSDictionary else { return nil }
        guard let bundleIconFiles = bundlePrimaryIcon["CFBundleIconFiles"] as? NSArray else { return nil }
        guard let appIcon = bundleIconFiles.lastObject as? String else { return nil }
        return appIcon
    }
    
    @objc func dismissKeyboard() {
        usernameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        nameTF.resignFirstResponder()
        ageTF.resignFirstResponder()
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch (textField) {
        case usernameTF :
            return (textField.text?.count ?? 0) + string.count - range.length <= 11
        case passwordTF :
            return (textField.text?.count ?? 0) + string.count - range.length <= 11
        case nameTF :
            return (textField.text?.count ?? 0) + string.count - range.length <= 11
        case ageTF :
            return (textField.text?.count ?? 0) + string.count - range.length <= 2
        default:
            return true
        }
        
    }
    
}

extension RegisterViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.isKind(of: Switch.self)) {
            return false
        }else {
            return true
        }
    }
    
}


protocol RegisterViewProtocols {
    func showSignUpSuccess()
    func showSignUpFailed(message: String)
}

extension RegisterViewController: RegisterViewProtocols {
    func showSignUpSuccess() {
        loadingAnimationView.hide()
        present(
            AlertController.showConfirmOnlyAlert(title: "提示", message: "注册成功，请回到登录页面登录。", action: { _ in
                self.navigationController?.popViewController(animated: true)
            }),
            animated: true,
            completion: nil)
    }
    
    func showSignUpFailed(message: String) {
        loadingAnimationView.hide()
        present(
            AlertController.showConfirmOnlyAlert(
                title: "提示",
                message: message,
                action: nil),
            animated: true,
            completion: nil)
    }
    
    
}









