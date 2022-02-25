//
//  LoginModuleRouter.swift
//  GymApp
//
//  Created by Chris on 2021/5/23.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

class LoginModuleRouter: LoginModuleRouterProtocol {
    
    var view: LoginModuleViewProtocol?
    
    static func build() -> UIViewController {
        
        // Use this method to create the module and the viewcontroller.
        let presenter : LoginModulePresenterProtocol = LoginModulePresenter()
        let view = LoginModuleView()
        let router : LoginModuleRouterProtocol = LoginModuleRouter()
        let interactor: LoginModuleInteractorProtocol = LoginModuleInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = view
        
        
        return view
    }
    
    func showMainScreen() {
        
        let vc = BottomTabBarController()
        
        view?.navigationTo(vc: vc)
    }
}
