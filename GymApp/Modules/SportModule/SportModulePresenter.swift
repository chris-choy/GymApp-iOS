//
//  SportModulePresenter.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class SportModulePresenter: SportModulePresenterProtocol {
    
    var view : SportModuleViewProtocol?
    var router: SportModuleRouterProtocol?
    var interactor: SportModuleInteractorProtocol?
    
    // To pass the data to Plan Edit page.
    var planPresenter: PlanCreatePresenterProtocol?
    
    func viewDidLoad() {
        
//        showSportsList()
    }
    
    
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
            
            view?.loadData(selectedList: selectedList,data: sportModels)
        }
        
    }
    
    func sendTheChoseResult(sports: [SportModel]?) {
        if let sports = sports {
            planPresenter?.addSectionInView(sports: sports)
        }
    }
    
}
