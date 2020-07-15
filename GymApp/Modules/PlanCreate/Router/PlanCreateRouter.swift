//
//  PlanCreateRouter.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class PlanCreateRouter: PlanCreateRouterProtocol {
    
    static func build() -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        
        let view = PlanCreateView()
        let presenter : PlanCreatePresenterProtocol = PlanCreatePresenter()
        let router : PlanCreateRouterProtocol = PlanCreateRouter()
        let interactor: PlanCreateInteractorProtocol = PlanCreateInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        presenter.viewDidLoad()
        
        return view
        
    }
    
    static func buildPlanListView() -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        
        let view = PlanListViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter : PlanCreatePresenterProtocol = PlanCreatePresenter()
        let router : PlanCreateRouterProtocol = PlanCreateRouter()
        let interactor: PlanCreateInteractorProtocol = PlanCreateInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        let nav = UINavigationController(rootViewController: view)
        
        // Do something.
        presenter.showAllPlans()

        return nav
    }
    
    func goToPlanEdit(plan: Plan) {
        
    }
    
    
    static func buildPlanEditView(plan: Plan) -> UIViewController {
        // Use this method to create the module and the viewcontroller.
        
        let view = PlanCreateView()
        
        let presenter : PlanCreatePresenterProtocol = PlanCreatePresenter()
        let router : PlanCreateRouterProtocol = PlanCreateRouter()
        let interactor: PlanCreateInteractorProtocol = PlanCreateInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        presenter.showEditPlan(plan: plan)
        
        return view
        
    }
    
    func showSportList(presenter: PlanCreatePresenterProtocol) -> UIViewController{
        let sportListVC = SportModuleRouter.buildListForChose(planPresenter: presenter)
        sportListVC.modalPresentationStyle = .popover
        
    
//        sportListVC.present(sportListVC, animated: true, completion: nil)
        return sportListVC
    }
    
//    func setPresenter(presenter: PlanCreatePresenterProtocol){
//        self.presenter = presenter
//    }
    
    func receiveTheSportResult(sports: [Sport]) {
        print(self)
//        presenter?.addSectionInView(sports: sports)
    }
    
    
    
}
