//
//  SportModuleRouter.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class SportModuleRouter: SportModuleRouterProtocol {
    
    var planRouter: PlanModuleRouterProtocol?
    
    static func build(planPresenter: PlanModulePresenterProtocol) -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        let view = SportListView()
        let presenter : SportModulePresenterProtocol = SportModulePresenter()
        let router : SportModuleRouterProtocol = SportModuleRouter()
        let interactor: SportModuleInteractorProtocol = SportModuleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.viewDidLoad()
        
        
        let nav = UINavigationController(rootViewController: view)
        return nav
    }
    
    static func buildListForChose(sections: [PlanSectionModel], planRouter: PlanModuleRouterProtocol) -> UIViewController {
        
//        let view = SportListView()
        let view = SportModuleView(viewMode: .choice)
        let presenter : SportModulePresenterProtocol = SportModulePresenter()
        let router : SportModuleRouterProtocol = SportModuleRouter()
        let interactor: SportModuleInteractorProtocol = SportModuleInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        router.planRouter = planRouter
        
        presenter.showSportsList(sections: sections)
        
        interactor.presenter = presenter
        
        let nav = UINavigationController(rootViewController: view)
        
        return nav
    }
    
    func sendTheChoseResult(sports: [SportModel]?) {
        if let sports = sports {
            planRouter?.receiveTheSportResult(sports: sports)
        }
    }
    
    public func buildSportModuleView() -> UITableViewController{
        let view = SportModuleView(viewMode: .manager)
        let presenter : SportModulePresenterProtocol = SportModulePresenter()
        let router : SportModuleRouterProtocol = SportModuleRouter()
        let interactor: SportModuleInteractorProtocol = SportModuleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.loadSportManagerViewData()
                
        return view
    }
    
}
