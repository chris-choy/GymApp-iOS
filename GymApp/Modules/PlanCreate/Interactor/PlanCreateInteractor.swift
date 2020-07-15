//
//  PlanCreateInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation


class PlanCreateInteractor: PlanCreateInteractorProtocol{
    
    let planManager = PlanCoreDataManager()
    
    func fetchPlan(name: String) -> Plan? {
        return PlanCoreDataManager().fetchPlan(name: name)
    }
    
    func fetchAllPlans() -> [Plan]? {
        return planManager.fetchAllPlans()
    }
    
}
