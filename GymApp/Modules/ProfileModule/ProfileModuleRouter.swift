//
//  ProfileModuleRouter.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class ProfileModuleRouter: ProfileModuleRouterProtocol {
    
    static func build() -> UIViewController {
        
        // Use this method to create the module and the viewcontroller.
        
        let view = ProfileModuleView()
        let presenter : ProfileModulePresenterProtocol = ProfileModulePresenter()
        let router : ProfileModuleRouterProtocol = ProfileModuleRouter()
        let interactor: ProfileModuleInteractorProtocol = ProfileModuleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
