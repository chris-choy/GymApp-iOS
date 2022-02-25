//
//  SportModulePresenter.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class SportModulePresenter: SportModulePresenterProtocol {

    func showCreateSuccess() {
        view?.showCreateSuccess()
    }
    
    func showFailMessage(message: String) {
        view?.showFailMessage(message: message)
    }
    
    func loadSportFail(){
        view?.loadSportFail()
    }

    var view : SportModuleViewProtocol?
    var router: SportModuleRouterProtocol?
    var interactor: SportModuleInteractorProtocol?
    
    // To pass the data to Plan Edit page.
    var planPresenter: PlanModulePresenterProtocol?
    
    func viewDidLoad() {
        
    }
    
//MARK: For Router
    // For router to call.
    func showSportsList(sections: [PlanSectionModel]){
        
        if let sports = interactor?.fetchAllSports(){
            
            let sportModels = sports.toSportModels()
            
            var selectedList = Array(repeating: false, count: sportModels.count)
            
            for index in 0 ... selectedList.count-1 {
                if(sections.contains(where: {$0.sport.name == sportModels[index].name})){
                    selectedList[index] = true
                }
            }
            
            view?.loadData(datas: sportModels)

        }
        
    }
    
    func loadSportManagerViewData(){
        let manager = SportDataManager()
        let fetchResult = manager.fetchAllSport()
        
        view?.loadData(datas: fetchResult.toSportModels())
    }
    
    func sendTheChoseResult(sports: [SportModel]?) {
        if let sports = sports {
            router?.sendTheChoseResult(sports: sports)
        }
    }
    
// MARK: For View
    
    // Sport.
    func saveSport(sport: SportModel, mode: SaveMode) {
        interactor?.saveSport(sport: sport,mode: mode)
    }
    
    func fetchAllSportFromServer() {
        interactor?.fetchAllSportFromServer()
    }
    
    // Tag.
    func getTagList() -> [SportTagModel]? {
        let manager = SportTagDataManager()
        if let result = manager.fetchAllTag() {
            if result.count == 0 {
                return nil
            }
            else {
                return result.toSportTagModels()
            }
        }
        return nil
    }
    func createTag(name: String) -> SportTagModel? {
        let manager = SportTagDataManager()
        
        if let result = manager.createTag(name: name) {
            return result.toSportTagModel()
        }
        else {
            return nil
        }
    }
    func isTagExists(name: String) -> Bool {
        let manager = SportTagDataManager()
        if manager.isAlreadyExits(name: name) {
            return true
        }
        else {
            return false
        }
    }
    
}
