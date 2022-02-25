//
//  LoginModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2021/5/23.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

protocol LoginModuleViewProtocol : class {
    
    var presenter: LoginModulePresenterProtocol? {set get}
    
    // Add some methods here.
    func navigationTo(vc : UIViewController)
    
    func showSignInErrorAlert(message: String)
    func showSignUpSuccess()
    func showSignUpFailed(message: String)
    
}

protocol LoginModuleRouterProtocol: AnyObject {
    
    var view : LoginModuleViewProtocol? {set get}
    
    static func build() -> UIViewController
    
    func showMainScreen()

}

protocol LoginModulePresenterProtocol: AnyObject {
    
    var view: LoginModuleViewProtocol? {set get}
    var router: LoginModuleRouterProtocol? {set get}
    var interactor: LoginModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
    
    func handleSignIn(username: String, password: String)
    func signUp(user: User)
    
    func showMainScreen()
    
    func showSignInErrorAlert(message: String)
    
    func showSignUpSuccess()
    func showSignUpFailed(message: String)
}

protocol LoginModuleInteractorProtocol: AnyObject {
    
    var presenter: LoginModulePresenterProtocol? {set get}
    
    func handleSignIn(username: String, password: String)
    func signUp(user: User)
}
