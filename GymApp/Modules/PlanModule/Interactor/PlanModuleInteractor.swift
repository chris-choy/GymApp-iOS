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
//                    self.presenter?.showAllPlans()
                    
                    DispatchQueue.main.async {
//                        self.presenter?.showAllPlans()
//                        self.presenter?.
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
    
    private func loadSport(){
        
    }
    
    
    fileprivate func loadPlan() {
        
//        var isSportOk = false
        
        SportService.shared.getAllSports { res in
            switch res {
            case .failure(let err):
                print(err)
                print("读取错误")
                self.presenter?.showErrorAlert()
            case .success(_):
//                print(Unmanaged.passUnretained(isSportOk).toOpaque())
                
//                isSportOk = true
                print("读取成功")
                
                // 2. Load Plan data.
                PlanService.shared.getAllPlans(completion: {
                    (res) in
                    
                    switch res {
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
        
//        // 2. Load Plan data.
//        PlanService.shared.getAllPlans(completion: {
//            (res) in
//
//            switch res {
//            case .failure(let err):
//                print(err)
//            case .success(_):
//                // Convert the result to PlanResponseModel.
//                if isSportOk {
//                    DispatchQueue.main.async {
//                        self.presenter?.showAllPlans()
//                    }
//                } else {
//                    // Tell the view that there is error.
//                    DispatchQueue.main.async {
//                        self.presenter?.showErrorAlert()
//                    }
//
//                }
//
//            }
//        })
        
        
    }
    
    func loadData() {
        
        // 1. Load Sport data.
//        loadSport()
        
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
            
        } catch {
            print(error)
        }
        
        
        
        
        return nil
    }
    
    
    
}
