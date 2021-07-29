//
//  LoginModulePresenter.swift
//  GymApp
//
//  Created by Chris on 2021/5/23.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation

class LoginModulePresenter: LoginModulePresenterProtocol {
    
    
    
    
    
    var view : LoginModuleViewProtocol?
    var router: LoginModuleRouterProtocol?
    var interactor: LoginModuleInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func handleSignIn(){
        interactor?.handleSignIn()
    }
    
    
    func showMainScreen() {
        router?.showMainScreen()
    }
    
    
    func showNetworkErrorAlert() {
        view?.showNetworkErrorAlert()
    }
}
