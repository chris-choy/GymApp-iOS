//
//  PlanService.swift
//  GymApp
//
//  Created by Chris on 2021/5/27.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

class PlanService: NSObject {
    static let shared = PlanService()
    
    let id_token = UserDefaults.standard.string(forKey: "id_token") as! String
    
    //#MARK: public
    func updatePlan(requestPlan: Data ,completion: @escaping (Result< (), Error>) -> ()){
        
        let url = URL(string: ConfigConstant.serverAdderss + "/plan/update")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer \(id_token)", forHTTPHeaderField: "Authorization")
        request.httpBody = requestPlan
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                print("error", error ?? "Unknown error")
                
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            guard response.statusCode == 200 else {
                // check for http errors
                print("There is error, status code =  \(response.statusCode)")
                let err = URLError(URLError.Code(rawValue: response.statusCode))
                
                completion(.failure(err))
                
                return
            }
            
            DispatchQueue.main.async {
                self.syncToCoreData(result: data)
            }
            
            
            
            completion(.success(()))
            
            
            
        }.resume()
        
        
    }
    
    
    func getAllPlans(completion: @escaping (Result< () , Error>) -> ()){
        
        print("idtoken=\(id_token)")
        
        // Set request information.
        let url = URL(string: ConfigConstant.serverAdderss + "/plan/all")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setValue("Bearer \(id_token)", forHTTPHeaderField: "Authorization")
        
        // Start the request.
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }
            
            guard response.statusCode == 200 else {
                // check for http errors
                print("There is error, status code =  \(response.statusCode)")
                return
            }
            
            // Do with the result.
            DispatchQueue.main.async {
                self.syncToCoreData(result: data)
            }
            
            completion(.success(()))

        }.resume()
        
    }
    
    // MARK: fileprivate
    fileprivate func isUpToDate(new: PlanModel, old: PlanModel) -> Bool{
        
        // Check for the plans and its timestamp.
        if ((old.last_changed == new.last_changed) &&
                (new.sectionList.count == old.sectionList.count)){
            
            if new.sectionList.count > 0 {
                for s in 0 ... new.sectionList.count-1 {
                    // Check the section.
                    let oldSection = old.sectionList[s]
                    let newSection = new.sectionList[s]
                    
                    if(oldSection.last_changed == oldSection.last_changed &&
                        oldSection.rowList.count == newSection.rowList.count){
                        for r in 0 ... oldSection.rowList.count-1 {
                            // Check the row.
                            let oldRow = oldSection.rowList[r]
                            let newRow = newSection.rowList[r]
                            
                            if (oldRow.last_changed != newRow.last_changed)  {
                                // Row false.
                                return false
                            }
                        }
                    } else {
                        // Section false.
                        return false
                    }
                }
            }
            
            return true
        } else {
            // Plan false.
            return false
        }
        
    }
    
    fileprivate func syncToCoreData(result: Data){
        do {
//            let t = String(data: result, encoding: .utf8)
            // 1. Transfrom result data to PlanModel.
            let plansResponse = try JSONDecoder().decode([PlanModel].self, from: result)
            let planCoredataManager = PlanCoreDataManager()
            
            // 2. To check if it needs to update the data in CoreData.
            if let oldPlans = planCoredataManager.fetchAllPlans(){
                var tags = [Bool](repeating: false, count: oldPlans.count)
                
                // 2.1 Clear the plan in the Coredata.
                if plansResponse.count == 0 {
                    for plan in oldPlans {
                        planCoredataManager.deletePlan(id: plan.objectID)
                    }
                } else {
                // 2.2 Check the plans in coredata if they are up-to-date.
                    for planModel in plansResponse {
                        
                        if let oldPlanIndex = oldPlans.firstIndex(where: {$0.id == planModel.id}){
                            
                            tags[oldPlanIndex] = true
                            
                            if(isUpToDate(new: planModel, old: oldPlans[oldPlanIndex].toPlanModel())  == false ){
                                // Delete and create the new plan.
                                planCoredataManager.deletePlan(id: oldPlans[oldPlanIndex].objectID)
                                _ = planCoredataManager.createPlan(model: planModel)
                            }
                        } else {
                            // Not exists or isn't up-to-date.
                            // Create plan.
                            _ = planCoredataManager.createPlan(model: planModel)
                        }
                        
                        // Delete the plan in coredata but not in result.
                        while true {
                            if let del = tags.firstIndex(where: { $0 == false }){
                                tags[del] = true
                                planCoredataManager.deletePlan(id: oldPlans[del].objectID)
                            } else {
                                break
                            }
                        }
                    }
                }
            }
            
        } catch  {
            
            print("PlanService.syncToCoreData: " + error.localizedDescription)
        }
    }
    
}
