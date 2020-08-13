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
    func loadData(selectedList: [Bool] ,data: [SportModel])
    
}

protocol SportModuleRouterProtocol: class {
    
    static func buildListForChose(sections: [PlanSectionModel], planPresenter: PlanCreatePresenterProtocol) -> UIViewController
    
    static func build(planPresenter: PlanCreatePresenterProtocol) -> UIViewController
    
    func sendTheChoseResult(sports: [SportModel]?)
}

protocol SportModulePresenterProtocol: class {
    
    var view: SportModuleViewProtocol? {set get}
    var router: SportModuleRouterProtocol? {set get}
    var interactor: SportModuleInteractorProtocol? {set get}
    var planPresenter: PlanCreatePresenterProtocol? { get set }
    
    // For router to call.
    func viewDidLoad()
    func showSportsList(sections: [PlanSectionModel])
    
    func sendTheChoseResult(sports: [SportModel]?)
    
}

protocol SportModuleInteractorProtocol: class {
    
    func fetchAllSports() -> [Sport]?
    
}
