//
//  SportModuleRouter.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class SportModuleRouter: SportModuleRouterProtocol {
    
//    var planRouter : PlanCreateRouterProtocol?
    
    static func build(planPresenter: PlanCreatePresenterProtocol) -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        let view = SportModuleView()
        let presenter : SportModulePresenterProtocol = SportModulePresenter()
        let router : SportModuleRouterProtocol = SportModuleRouter()
        let interactor: SportModuleInteractorProtocol = SportModuleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
//        presenter.viewDidLoad()
        presenter.showSportsList()
        
        
        let nav = UINavigationController(rootViewController: view)
        return nav
    }
    
//    static func build() -> UIViewController {
//            // Use this method to create the module and the viewcontroller.
//            let view = SportModuleView()
//            let presenter : SportModulePresenterProtocol = SportModulePresenter()
//            let router : SportModuleRouterProtocol = SportModuleRouter()
//            let interactor: SportModuleInteractorProtocol = SportModuleInteractor()
//
//            view.presenter = presenter
//            presenter.view = view
//            presenter.router = router
//            presenter.interactor = interactor
//
//            presenter.viewDidLoad()
//
//
//
//            let nav = UINavigationController(rootViewController: view)
//            return nav
//    }
    
    static func buildListForChose(planPresenter: PlanCreatePresenterProtocol) -> UIViewController {
        let view = SportModuleView()
        let presenter : SportModulePresenterProtocol = SportModulePresenter()
        let router : SportModuleRouterProtocol = SportModuleRouter()
        let interactor: SportModuleInteractorProtocol = SportModuleInteractor()
        
//        router.setPlanRouter(router: planRouter)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.planPresenter = planPresenter
        
        presenter.viewDidLoad()
        
        let nav = UINavigationController(rootViewController: view)
        
        return nav
    }
    
//    func setPlanRouter(router: PlanCreateRouterProtocol) {
//        planRouter = router
//    }
    
    func sendTheChoseResult(sports: [Sport]?) {
        if let sports = sports {
//            planRouter?.receiveTheSportResult(sports: sports)
        }
    }
}
