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
    
    func updatePlan(plan: PlanModel) {
        
        do {
            let planJson = try JSONEncoder().encode(plan)
            
            print(String(decoding: planJson, as: UTF8.self))

            // 1. Update to database.
            PlanService.shared.updatePlan(requestPlan: planJson) { res in
                switch(res){
                case .success(_):
                    
                    // Tell the view to update the plan data.
                    DispatchQueue.main.async {
                        self.presenter?.showUpdateSuccessfully()
                    }
                    
                case .failure(let err):
                    DispatchQueue.main.async {
                        self.presenter?.showUpdateError()
                    }
                    print(err)
                }
            }
        } catch {
            print("error")
        }
        
    }
    
    fileprivate func loadPlan() {
        // 1. Load sport data first.
        SportService.shared.getAllSports { res in
            switch res {
            case .failure(let err):
                print(err)
                print("读取错误")
                self.presenter?.showErrorAlert()
            case .success(_):
                // 2. Load plan data.
                PlanService.shared.getAllPlans(completion: {
                    (res) in switch res {
                    case .failure(let err):
                        print(err)
                        self.presenter?.showErrorAlert()
                    case .success(_):
                        // Convert the result to PlanResponseModel.
                        DispatchQueue.main.async {
                            self.presenter?.showAllPlans()
                        }
                    }
                })
            }
        }
    }
    
    func loadData() {
        loadPlan()
    }
    
//MARK: Service.
    func savePlan(requestPlan: PlanModel) -> PlanModel? {
        
        // Output the plan json string.
        do {
            let json = try JSONEncoder().encode(requestPlan)
            
            PlanService.shared.updatePlan(requestPlan: json, completion: {
                res in
                switch(res){
                case .success(_):
                    print("a")
                case .failure(let error):
                    print(error)
                }
            })
            
        } catch {
            print(error)
        }
        return nil
    }

}
