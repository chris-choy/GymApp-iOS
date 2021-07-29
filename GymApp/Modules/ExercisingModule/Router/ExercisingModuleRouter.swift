//
//  ExercisingModuleRouter.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class ExercisingModuleRouter: ExercisingModuleRouterProtocol {
    
    static func build() -> UIViewController {
        
        /*
        
        // Use this method to create the module and the viewcontroller.
        
        let view = ExercisingModuleView()
        let presenter : ExercisingModulePresenterProtocol = ExercisingModulePresenter()
        let router : ExercisingModuleRouterProtocol = ExercisingModuleRouter()
        let interactor: ExercisingModuleInteractorProtocol = ExercisingModuleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        return view
 
        */
        return UIViewController()
    }
    
    static func buildExercisingView(planMoldel: PlanModel) -> UIViewController {
        
        // Use this method to create the module and the viewcontroller.
        let view = ExercisingModuleView(planModel: planMoldel)
        let presenter : ExercisingModulePresenterProtocol = ExercisingModulePresenter()
        let router : ExercisingModuleRouterProtocol = ExercisingModuleRouter()
        let interactor: ExercisingModuleInteractorProtocol = ExercisingModuleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        return view
    }
}
