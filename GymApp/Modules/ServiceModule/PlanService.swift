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
    func updatePlan(requestPlan: String ,completion: @escaping (Result< (), Error>) -> ()){
        let url = URL(string: ConfigConstant.serverAdderss + "/plan/update")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer \(id_token)", forHTTPHeaderField: "Authorization")
        request.httpBody = requestPlan.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                print("error", error ?? "Unknown error")
                return
            }
            
            guard response.statusCode == 200 else {
                // check for http errors
                print("There is error, status code =  \(response.statusCode)")
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
    fileprivate func syncToCoreData(result: Data){
        do {
            let plansResponse = try JSONDecoder().decode([PlanModel].self, from: result)
            for planModel in plansResponse {
                
                let planCoredataManager = PlanCoreDataManager()
                // Check for the plans and its timestamp.
                if let p = planCoredataManager.fetchPlan(id: planModel.id){
                    if (p.last_changed != planModel.last_changed){
                        // Update the plan.
                        print("需要更新plan的数据。")
                        
                        // Delete the old data and create the new data.
                        planCoredataManager.deletePlan(id: p.objectID)
                        
                        // Create the new plan.
                        _ = planCoredataManager.createPlan(model: planModel)
                        
                    }
                } else {
                    // Create plan.
                    if let result = planCoredataManager.createPlan(model: planModel) {
                        print("创建成功。")
                    } else {
                        print("创建失败。")
                    }
                }
                
            }
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
}
