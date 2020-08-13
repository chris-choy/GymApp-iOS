//
//  PlanCreatePresenter.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//enum Type {
//    case listPage
//    case editPage
//}


class PlanCreatePresenter: PlanCreatePresenterProtocol {
    
    var view : PlanCreateViewProtocol?
    var router: PlanCreateRouterProtocol?
    var interactor: PlanCreateInteractorProtocol?

    
    func viewDidLoad() {
        
    }
    
    func fetchPlan(name: String) -> Plan? {
        return interactor?.fetchPlan(name: name)
    }
    
    
    // Tell the view to do.
    func showAllPlans(){
        if let p = interactor!.fetchAllPlans() {
            view?.loadData(data: p)
        }
    }
    
    func showEditPlan(plan: PlanModel) {
        view?.loadData(data: plan)
    }
    
    func buildSportListView(sections: [PlanSectionModel]) -> UIViewController{
        return router!.showSportList(sections: sections, presenter: self)
    }
    
    func addSectionInView(sports: [SportModel]) {
        
        var sections: [PlanSectionModel] = []
        
        for sport in sports {
            let section = PlanSectionModel(
                sectionIndex: 0,
                unit: sport.unit.name,
                sport: sport)
            sections.append(section)
        }
        view?.addSection(sections: sections)
    }
    
    func savePlan(plan: PlanModel) -> Bool {
        if(interactor!.updatePlan(plan: plan)) {
            return true
        } else {
            return false
        }
    }
}
