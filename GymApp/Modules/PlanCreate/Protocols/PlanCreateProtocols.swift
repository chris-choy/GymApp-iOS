//
//  PlanCreateProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol PlanCreateViewProtocol : class {
    
    var presenter: PlanCreatePresenterProtocol? {set get}
    
    // Add some methods here.
    func loadData(plans: [Plan])
    func addSection(sections: [PlanSection])
    
}

protocol PlanCreateRouterProtocol: class {
    
    static func build() -> UIViewController
    static func buildPlanEditView(plan: Plan) -> UIViewController
    
//    func buildPlanEditView(plan: Plan) -> UIViewController
//    func buildPlanEditView(plan: Plan)
    
//    func showSportList()
    func showSportList(presenter: PlanCreatePresenterProtocol) -> UIViewController
    
    // For Sport Module to call.
    func receiveTheSportResult(sports: [Sport])
}

protocol PlanCreatePresenterProtocol: class {
    
    var view: PlanCreateViewProtocol? {set get}
    var router: PlanCreateRouterProtocol? {set get}
    var interactor: PlanCreateInteractorProtocol? {set get}
    
    func viewDidLoad()
    
    // Core Data .
    func fetchPlan(name: String) -> Plan?
    
    // The view to do.
    func showAllPlans()
    func showEditPlan(plan: Plan)
    func addSectionInView(sports: [Sport])
    
    // For view to call.
    func buildSportListView() -> UIViewController
    
}

protocol PlanCreateInteractorProtocol: class {
    
    func fetchPlan(name: String) -> Plan?
    func fetchAllPlans() -> [Plan]?
    
}
