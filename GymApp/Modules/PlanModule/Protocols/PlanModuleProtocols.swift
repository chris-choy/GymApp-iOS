//
//  PlanEditProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol PlanModuleViewProtocol : AnyObject {
    
    var presenter: PlanModulePresenterProtocol? {set get}
    
    func showData(planModel: [PlanModel])
    func addSection(sections: [PlanSectionModel])
//    func reloadData()
    
    func showErrorAlert()
    func showUpdateError()
    func showUpdateSuccessfully()

}

protocol PlanModuleRouterProtocol: AnyObject {
    
    static func buildPlanEditView(plan: PlanModel, listPresenter: PlanModulePresenterProtocol) -> UIViewController
    static func buildPlanEditViewToCreate(listPresenter: PlanModulePresenterProtocol) -> UIViewController

    func showSportList(sections: [PlanSectionModel], presenter: PlanModulePresenterProtocol) -> UIViewController
    
    // For Sport Module to call.
    func receiveTheSportResult(sports: [Sport])
    
    // For PlanListView to create the Exercising View.
    func buildExercisingModuleView(planModel: PlanModel) -> UIViewController
}

protocol PlanModulePresenterProtocol: AnyObject {
    
    var view: PlanModuleViewProtocol? {set get}
    var router: PlanModuleRouterProtocol? {set get}
    var interactor: PlanModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
    
    // Core Data .
    func fetchPlan(name: String) -> Plan?
    
    
    // The view to do.
    func showAllPlans()
//    func showEditPlan(plan: PlanModel)
    func addSectionInView(sports: [SportModel])
    func showErrorAlert()
    func showUpdateError()
    func showUpdateSuccessfully()
    
    // For view to call.
    func buildSportListView(sections: [PlanSectionModel]) -> UIViewController
//    func buildPlanEditViewToEdit(plan: PlanModel) -> UIViewController
    func buildPlanEditViewToCreate() -> UIViewController
    func buildExercisingModuleView(planModel: PlanModel) -> UIViewController
    func savePlan(plan: PlanModel)
    func createPlan(plan: PlanModel) -> PlanModel?
    
    // PlanService.
    func loadData()
    
    // View to Server
    func savePlan(requestPlan: PlanModel) -> PlanModel?
    
    
    
    
}

protocol PlanModuleInteractorProtocol: AnyObject {
    
    var presenter : PlanModulePresenterProtocol? { get set }
    
    func fetchPlan(name: String) -> Plan?
    func fetchAllPlans() -> [Plan]?
    func updatePlan(plan: PlanModel)
    func createPlan(plan: PlanModel) -> PlanModel?
    func savePlan(requestPlan: PlanModel) -> PlanModel?
    
    
    // PlanService
    func loadData()
    
    
    
    
}
