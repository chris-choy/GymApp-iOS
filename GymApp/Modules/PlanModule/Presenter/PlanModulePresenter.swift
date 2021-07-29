//
//  PlanEditPresenter.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class PlanModulePresenter: PlanModulePresenterProtocol {
    func savePlan(requestPlan: PlanModel) -> PlanModel? {
        return interactor?.savePlan(requestPlan: requestPlan)
    }
    
    
    
    
    
    
    var view : PlanModuleViewProtocol?
    var router: PlanModuleRouterProtocol?
    var interactor: PlanModuleInteractorProtocol?

    
    func viewDidLoad() {
        
    }
    
    // MARK: Build ViewController
    
    func buildPlanEditViewToCreate() -> UIViewController {
        return PlanModuleRouter.buildPlanEditViewToCreate(listPresenter: self)
    }
    
    func buildPlanEditViewToEdit(plan: PlanModel) -> UIViewController {
        return PlanModuleRouter.buildPlanEditView(plan: plan, listPresenter: self)
    }
    
    // Sport
    func buildSportListView(sections: [PlanSectionModel]) -> UIViewController{
        // For PlanEditView to create the sport list page to chose sport to add into the plan.
        return router!.showSportList(sections: sections, presenter: self)
    }
    
    // For PlanListView to create the Exercising Module View
    func buildExercisingModuleView(planModel: PlanModel) -> UIViewController{
        return router!.buildExercisingModuleView(planModel: planModel)
    }
    
    
    
// MARK: Fow view to call.
    func fetchPlan(name: String) -> Plan? {
        return interactor?.fetchPlan(name: name)
    }
    
    // Tell the view to do.
    func showAllPlans(){
        if let p = interactor!.fetchAllPlans() {
            view?.loadData(data: p.toPlanModels())
        }
    }
    
    func showEditPlan(plan: PlanModel) {
        view?.loadData(data: plan)
    }
    
    
    
    func addSectionInView(sports: [SportModel]) {
        
        var sections: [PlanSectionModel] = []
        
        for sport in sports {
            let section = PlanSectionModel(
                id: 0,
                seq: 0,
                unit: sport.unit.name,
                rowList: [],
                sport: sport,last_changed: 0,
                plan_id: 0)
            sections.append(section)
        }
        view?.addSection(sections: sections)
    }
    
    func savePlan(plan: PlanModel) -> Bool {
//        if(interactor!.updatePlan(plan: plan)) {
//            return true
//        } else {
//            return false
//        }
        
        return interactor!.updatePlan(plan: plan)
    }
    
    func createPlan(plan: PlanModel) -> PlanModel? {
        return interactor?.createPlan(plan: plan)
    }
    
    
//#MARK: Tell view to do.
    
    func showErrorAlert(){
        view?.showErrorAlert()
    }
    
    func loadData() {
        interactor?.loadData()
    }
    

}
