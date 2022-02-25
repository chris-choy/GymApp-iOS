//
//  LoginModulePresenter.swift
//  GymApp
//
//  Created by Chris on 2021/5/23.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation

class LoginModulePresenter: LoginModulePresenterProtocol {
    func showSignUpSuccess() {
        view?.showSignUpSuccess()
    }
    
    func showSignUpFailed(message: String) {
        view?.showSignUpFailed(message: message)
    }
    
    var view : LoginModuleViewProtocol?
    var router: LoginModuleRouterProtocol?
    var interactor: LoginModuleInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func handleSignIn(username: String, password: String){
        interactor?.handleSignIn(username: username, password: password)
    }
    
    func signUp(user: User) {
        interactor?.signUp(user: user)
    }
    
    func showMainScreen() {
        router?.showMainScreen()
    }
    
    func showSignInErrorAlert(message: String) {
        view?.showSignInErrorAlert(message: message)
    }
    
    
}
