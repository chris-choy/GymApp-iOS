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
        
        showSportsList()

    }
    
    
    // For router to call.
    func showSportsList(){
        
        if let sports = interactor?.fetchAllSports(){
            view?.showSports(sports: sports)
        }
        
    }
    
    func sendTheChoseResult(sports: [Sport]?) {
//        router?.sendTheChoseResult(sports: sports)
        if let s = sports {
            planPresenter?.addSectionInView(sports: s)
        }
    }
    
}
