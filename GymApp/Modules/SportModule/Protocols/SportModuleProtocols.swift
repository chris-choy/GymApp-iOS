//
//  SportModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

enum SaveMode {
    case create
    case edit
}

enum ViewMode {
    case manager
    case choice
}

protocol SportModuleViewProtocol : class {
    
    var presenter: SportModulePresenterProtocol? {set get}
    
    // Add some methods here.
//    func loadData(selectedList: [Bool] ,data: [SportModel])
    
    func loadData(datas: [Any])
    
    func showCreateSuccess()
    func showFailMessage(message: String)
    func loadSportFail()
    
}

protocol SportModuleRouterProtocol: class {
    
    var planRouter: PlanModuleRouterProtocol? {set get}
    
    static func buildListForChose(sections: [PlanSectionModel], planRouter: PlanModuleRouterProtocol) -> UIViewController
    
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
//    func createSport(sport: SportModel) -> SportModel?
    func saveSport(sport: SportModel, mode: SaveMode)
//    func updateSport(sport: SportModel)
    func fetchAllSportFromServer()
    
    // Tag.
    func getTagList() -> [SportTagModel]?
    func createTag(name: String) -> SportTagModel?
    func isTagExists(name: String) -> Bool
    
    // For interactor.
    func showCreateSuccess()
    func showFailMessage(message: String)
    func loadSportFail()
    
    // Unit.
//    func getUnitList() -> [SportUnitModel]?
//    func createUnit(name: String) -> SportUnitModel?
//    func isUnitExists(name: String) -> Bool
}

protocol SportModuleInteractorProtocol: class {
    
    var presenter: SportModulePresenterProtocol? {set get}
    
    func fetchAllSports() -> [Sport]?
    
    func saveSport(sport: SportModel, mode: SaveMode)
//    func updateSport(sport: SportModel)
    func fetchAllSportFromServer()
    
}
