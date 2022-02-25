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

protocol SportModuleViewProtocol : AnyObject {
    
    var presenter: SportModulePresenterProtocol? {set get}
    
    // Add some methods here.
//    func loadData(selectedList: [Bool] ,data: [SportModel])
    
    func loadData(datas: [SportModel])
    
    func showCreateSuccess()
    func showFailMessage(message: String)
    func loadSportFail()
    
}

protocol SportModuleRouterProtocol: AnyObject {
    
    var planRouter: PlanModuleRouterProtocol? {set get}
    
    static func buildListForChose(sections: [PlanSectionModel], planRouter: PlanModuleRouterProtocol) -> UIViewController

    func sendTheChoseResult(sports: [SportModel]?)
}

protocol SportModulePresenterProtocol: AnyObject {
    
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
    func saveSport(sport: SportModel, mode: SaveMode)
    func fetchAllSportFromServer()
    
    // Tag.
    func getTagList() -> [SportTagModel]?
    func createTag(name: String) -> SportTagModel?
    func isTagExists(name: String) -> Bool
    
    // For interactor.
    func showCreateSuccess()
    func showFailMessage(message: String)
    func loadSportFail()
    
}

protocol SportModuleInteractorProtocol: AnyObject {
    
    var presenter: SportModulePresenterProtocol? {set get}
    
    func fetchAllSports() -> [Sport]?
    
    func saveSport(sport: SportModel, mode: SaveMode)
    func fetchAllSportFromServer()
    
}
