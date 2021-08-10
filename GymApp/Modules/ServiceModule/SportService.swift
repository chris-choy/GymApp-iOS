//
//  SportService.swift
//  GymApp
//
//  Created by Chris on 2021/7/26.
//  Copyright © 2021 Chris. All rights reserved.
//



import UIKit

class SportService: NSObject {
    static let shared = SportService()
    
    let id_token = UserDefaults.standard.string(forKey: "id_token")!
    
//    func updatePlan(requestPlan: String ,completion: @escaping (Result<Data, Error>) -> ()){
//        let url = URL(string: ConfigConstant.serverAdderss + "/plan/update")!
//
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(id_token)", forHTTPHeaderField: "Authorization")
//        request.httpBody = requestPlan.data(using: .utf8)
//
//        URLSession.shared.dataTask(with: request){
//            data, response, error in
//            guard let data = data,
//                  let response = response as? HTTPURLResponse,
//                  error == nil else {
//                print("error", error ?? "Unknown error")
//                return
//            }
//
//            guard response.statusCode == 200 else {
//                // check for http errors
//                print("There is error, status code =  \(response.statusCode)")
//                return
//            }
//
//
//            completion(.success(data))
//
//
//
//        }.resume()
//
//
//    }

    
    
    func getAllSports(completion: @escaping (Result < () ,Error> ) -> ()){
        
        // Set request information.
        let url = URL(string: ConfigConstant.serverAdderss + "/sport/all")!
        
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
            self.syncToCoreData(data: data)
            completion(.success(()))
        
            
        }.resume()
        
    }
    
    
    
    fileprivate func getAllSports_bak(completion: @escaping (Result< Data , Error>) -> ()){
        
        // Set request information.
        let url = URL(string: ConfigConstant.serverAdderss + "/sport/all")!
        
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
            completion(.success(data))
        
            
        }.resume()
        
    }
    
    
    // #MARK: fileprivate
    fileprivate func syncToCoreData(data: Data){
        do {
            let sports = try JSONDecoder().decode([SportModel].self, from: data)
            
            // Check if they need to be updated.
            let manager = SportDataManager()
            for sport in sports {
                if let sportInCD = manager.fetchSport(name: sport.name) {
                    if sportInCD.toSportModel().last_changed != sport.last_changed {
                        
                        // Need to be updated.
                        manager.updateSport(objectId: sportInCD.objectID, requestModel: sport)
                        
                    }
                } else {
                    // Not exists, create it.
                     _ = manager.createSport(model: sport)
                }
                
                
            }
            
        } catch {
            
            print("SportSerVice.syncToCoreData: \(error)")
        }
    }
    
}
