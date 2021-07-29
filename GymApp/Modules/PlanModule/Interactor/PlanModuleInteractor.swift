//
//  PlanEditInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation


class PlanModuleInteractor: PlanModuleInteractorProtocol {
    
    
    var presenter: PlanModulePresenterProtocol?
    
    let planManager = PlanCoreDataManager()
    
    func fetchPlan(name: String) -> Plan? {
        return planManager.fetchPlan(name: name)
    }
    
    func fetchAllPlans() -> [Plan]? {
        return planManager.fetchAllPlans()
    }
    
    func createPlan(plan: PlanModel) -> PlanModel? {
        // Create Plan.
        if let result = planManager.createPlan(model: plan) {
            return result.toPlanModel()
        }
        
        return nil
    }
    
    func updatePlan(plan: PlanModel) -> Bool {
        if (plan.objectId != nil) {
            if(planManager.updatePlan(plan: plan)){
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    private func loadSport(){
        
    }
    
    
    fileprivate func loadPlan() {
        
        var isSportOk = false
        
        SportService.shared.getAllSports { res in
            switch res {
            case .failure(let err):
                print(err)
            case .success(_):
                isSportOk = true
            }
        }
        
        // 2. Load Plan data.
        PlanService.shared.getAllPlans(completion: {
            (res) in
            
            switch res {
            case .failure(let err):
                print(err)
            case .success(_):
                // Convert the result to PlanResponseModel.
                if isSportOk {
                    DispatchQueue.main.async {
                        self.presenter?.showAllPlans()
                    }
                } else {
                    // Tell the view that there is error.
                    self.presenter?.showErrorAlert()
                }
                
                
                
//                do {
//                    let plansResponse = try JSONDecoder().decode([PlanModel].self, from: result)
//                    for planModel in plansResponse {
//
//                        let planCoredataManager = PlanCoreDataManager()
//                        // Check for the plans and its timestamp.
//                        if let p = planCoredataManager.fetchPlan(id: planModel.id){
//                            if (p.last_changed != planModel.last_changed){
//                                // Update the plan.
//                                print("需要更新plan的数据。")
//
//                                // Delete the old data and create the new data.
//                                planCoredataManager.deletePlan(id: p.objectID)
//
//                                // Create the new plan.
//                                planCoredataManager.createPlan(model: planModel)
//
//                            }
//                        } else {
//                            // Create plan.
//                            if let result = planCoredataManager.createPlan(model: planModel) {
//                                print("创建成功。")
//                            } else {
//                                print("创建失败。")
//                            }
//                        }
//
//                    }
//
//                } catch  {
//                    print(error.localizedDescription)
//                }
                
                
                
                
            }
            
            
            
        })
    }
    
    func loadData() {
        
        // 1. Load Sport data.
        loadSport()
        
        loadPlan()
    }
    
//MARK: Service.
    func savePlan(requestPlan: PlanModel) -> PlanModel? {
        
        // Output the plan json string.
        do {
            let data = try JSONEncoder().encode(requestPlan)
            if let str = String(data: data, encoding: .utf8){
                PlanService.shared.updatePlan(requestPlan: str, completion: {
                    res in
                    switch(res){
                    case .success(_):
//                        self.presenter?.loadData()
                    print("a")
                    
//                        do {
//                            let responsePlan = try JSONDecoder().decode(PlanModel.self, from: result)
//
//                            // 1. According to the plan_id, fetch the plan object in the CoreData.
//                            //    Create the object if not exists.
//
//
//                        } catch {
//                            print(error)
//                        }
                    case .failure(let error):
                        print(error)
                    }
                })
            }
            
        } catch {
            print(error)
        }
        
        
        
        
        return nil
    }
    
    
    
}
