//
//  PlanEditRouter.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class PlanModuleRouter: PlanModuleRouterProtocol {
    
    var presenter: PlanModulePresenterProtocol?
    
// MARK: Build View Controller.
    
    // Build page.
    
    static func buildPlanListView() -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        
        let view = PlanListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter : PlanModulePresenterProtocol = PlanModulePresenter()
        let router : PlanModuleRouterProtocol = PlanModuleRouter()
        let interactor: PlanModuleInteractorProtocol = PlanModuleInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        router.presenter = presenter

        // Do something.
        interactor.loadData()

        return view
    }
    
    static func buildPlanEditView(plan: PlanModel, listPresenter: PlanModulePresenterProtocol) -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        return UIViewController()
    }
    
    static func buildPlanEditViewToCreate(listPresenter: PlanModulePresenterProtocol) -> UIViewController {

        return UIViewController()

    }
    
// MARK: Navigation
    // Navigation
    func goToPlanEdit(plan: Plan) {
        
    }
    
    func showSportList(sections: [PlanSectionModel], presenter: PlanModulePresenterProtocol) -> UIViewController{
        
        let sportListVC = SportModuleRouter.buildListForChose(sections: sections, planRouter: self)
        sportListVC.modalPresentationStyle = .popover
        
        return sportListVC
    }
    
    func receiveTheSportResult(sports: [SportModel]) {
        presenter?.addSectionInView(sports: sports)
    }
    
    func buildExercisingModuleView(planModel: PlanModel) -> UIViewController {
        return ExercisingModuleRouter.buildExercisingView(planMoldel: planModel)
    }
    
}
