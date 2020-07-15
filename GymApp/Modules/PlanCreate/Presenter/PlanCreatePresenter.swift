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
            view?.loadData(plans: p)
        }
    }
    
    func showEditPlan(plan: Plan) {
        let plans = [plan]
        view?.loadData(plans: plans)
    }
    
    func buildSportListView() -> UIViewController{
        return router!.showSportList(presenter: self)
    }
    
    func addSectionInView(sports: [Sport]) {
        print("addSectionInView")
        for s in sports{
            print(s.name!)
        }
        
//        var sections =
        
//        let section = PlanSection
        
//        section.sport = sport
//        sections.append(section)
        
        // 在这里添加view的动作
//        view?.addSection(sections: sections)
    }
}
