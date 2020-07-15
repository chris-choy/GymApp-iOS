//
//  SportModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol SportModuleViewProtocol : class {
    
    var presenter: SportModulePresenterProtocol? {set get}
    
    // Add some methods here.
    func showSports(sports: [Sport])
    
}

protocol SportModuleRouterProtocol: class {
    
//    static func build() -> UIViewController
    static func buildListForChose(planPresenter: PlanCreatePresenterProtocol) -> UIViewController
    
    // Test.
    // For plan edit page to call.
    static func build(planPresenter: PlanCreatePresenterProtocol) -> UIViewController
    
    func sendTheChoseResult(sports: [Sport]?)
//    func setPlanRouter(router: PlanCreateRouterProtocol)
}

protocol SportModulePresenterProtocol: class {
    
    var view: SportModuleViewProtocol? {set get}
    var router: SportModuleRouterProtocol? {set get}
    var interactor: SportModuleInteractorProtocol? {set get}
    var planPresenter: PlanCreatePresenterProtocol? { get set }
    
    // For router to call.
    func viewDidLoad()
    func showSportsList()
    
    func sendTheChoseResult(sports: [Sport]?)
    
}

protocol SportModuleInteractorProtocol: class {
    
    func fetchAllSports() -> [Sport]?
    
}
