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
            
            self.syncToCoreData(result: data)
            
            completion(.success(()))
            
            
            
        }.resume()
        
        
    }
    
    
    func getAllPlans(completion: @escaping (Result< () , Error>) -> ()){
//        let id_token = UserDefaults.standard.string(forKey: "id_token") as! String
        
        // Set request information.
        let url = URL(string: ConfigConstant.serverAdderss + "/plan/complete")!
        
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
            self.syncToCoreData(result: data)
            
            
            
            completion(.success(()))
        
            
        }.resume()
        
    }
    
    
    
    // MARK: fileprivate
    
    fileprivate func isUpToDate(new: PlanModel, old: PlanModel) -> Bool{
        
        // Check for the plans and its timestamp.
        if ((old.last_changed == new.last_changed) &&
                (new.sectionList.count == old.sectionList.count)){
            
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
    
            return true
        } else {
            // Plan false.
            return false
        }
        
    }
    
    fileprivate func syncToCoreData(result: Data){
        do {
            let plansResponse = try JSONDecoder().decode([PlanModel].self, from: result)
            let planCoredataManager = PlanCoreDataManager()
            
            for planModel in plansResponse {
                
                if let oldPlan = planCoredataManager.fetchPlan(id: planModel.id){
                    if (isUpToDate(new: planModel, old: oldPlan.toPlanModel()) == false){
                        // Delete and create the new plan.
                        planCoredataManager.deletePlan(id: oldPlan.objectID)
                    } else {
                        break
                    }
                }
                
                // Not exists or isn't up-to-date.
                // Create plan.
                _ = planCoredataManager.createPlan(model: planModel)
                
            }
            
        } catch  {
            
            print("PlanService.syncToCoreData: " + error.localizedDescription)
        }
    }
    
}
