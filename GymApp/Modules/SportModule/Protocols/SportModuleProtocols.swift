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
//    func loadData(selectedList: [Bool] ,data: [SportModel])
    
    func loadData(datas: [Any])
    
}

protocol SportModuleRouterProtocol: class {
    
    static func buildListForChose(sections: [PlanSectionModel], planPresenter: PlanModulePresenterProtocol) -> UIViewController
    
    static func build(planPresenter: PlanModulePresenterProtocol) -> UIViewController
    
    func sendTheChoseResult(sports: [SportModel]?)
}

protocol SportModulePresenterProtocol: class {
    
    var view: SportModuleViewProtocol? {set get}
    var router: SportModuleRouterProtocol? {set get}
    var interactor: SportModuleInteractorProtocol? {set get}
    var planPresenter: PlanModulePresenterProtocol? { get set }
    
    // For router to call.
    func viewDidLoad()
    func showSportsList(sections: [PlanSectionModel])
    func loadSportManagerViewData()
    
    func sendTheChoseResult(sports: [SportModel]?)
    
    // For View to call.
    // Sport.
    func createSport(name: String, unit: String, tag: String?) -> SportModel?
    
    // Tag.
    func getTagList() -> [SportTagModel]?
    func createTag(name: String) -> SportTagModel?
    func isTagExists(name: String) -> Bool
    
    // Unit.
//    func getUnitList() -> [SportUnitModel]?
//    func createUnit(name: String) -> SportUnitModel?
//    func isUnitExists(name: String) -> Bool
}

protocol SportModuleInteractorProtocol: class {
    
    func fetchAllSports() -> [Sport]?
    
}
