//
//  PlanEditRouter.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class PlanModuleRouter: PlanModuleRouterProtocol {
    
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
        
//        let nav = UINavigationController(rootViewController: view)
        
        // Do something.
        presenter.showAllPlans()

        return view
    }
    
    
    static func buildPlanEditView(plan: PlanModel, listPresenter: PlanModulePresenterProtocol) -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        
        let view = PlanEditView(listPresenter: listPresenter )
        
        let presenter : PlanModulePresenterProtocol = PlanModulePresenter()
        let router : PlanModuleRouterProtocol = PlanModuleRouter()
        let interactor: PlanModuleInteractorProtocol = PlanModuleInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        presenter.showEditPlan(plan: plan)
        
        return view
        
    }
    
    static func buildPlanEditViewToCreate(listPresenter: PlanModulePresenterProtocol) -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        
        let view = PlanEditView(listPresenter: listPresenter)
        
        
        let presenter : PlanModulePresenterProtocol = PlanModulePresenter()
        let router : PlanModuleRouterProtocol = PlanModuleRouter()
        let interactor: PlanModuleInteractorProtocol = PlanModuleInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        // Build the view controller to create the new Plan.
        // Create a new planModel with a nil ObjectId provided to edit.
        
        presenter.showEditPlan(plan: PlanModel(id: 0, objectId: nil, name: "", sectionList: [], last_changed: 0, seq: 0, user_id: 0))
        
        return view
        
    }
    
    
    //    static func build() -> UIViewController {
    //        // Use this method to create the module and the viewcontroller.
    //
    //        let view = PlanEditView()
    //        let presenter : PlanEditPresenterProtocol = PlanEditPresenter()
    //        let router : PlanEditRouterProtocol = PlanEditRouter()
    //        let interactor: PlanEditInteractorProtocol = PlanEditInteractor()
    //
    //        view.presenter = presenter
    //        presenter.view = view
    //        presenter.router = router
    //        presenter.interactor = interactor
    //
    //        presenter.viewDidLoad()
    //
    //        return view
    //
    //    }
    
// MARK: Navigation
    // Navigation
    func goToPlanEdit(plan: Plan) {
        
    }
    
    func showSportList(sections: [PlanSectionModel], presenter: PlanModulePresenterProtocol) -> UIViewController{
        
        let sportListVC = SportModuleRouter.buildListForChose(sections: sections, planPresenter: presenter)
        sportListVC.modalPresentationStyle = .popover
        
    
//        sportListVC.present(sportListVC, animated: true, completion: nil)
        return sportListVC
    }
    
    func receiveTheSportResult(sports: [Sport]) {
//        print(self)
//        presenter?.addSectionInView(sports: sports)
    }
    
    
    func buildExercisingModuleView(planModel: PlanModel) -> UIViewController {
        return ExercisingModuleRouter.buildExercisingView(planMoldel: planModel)
    }
    
 
}
