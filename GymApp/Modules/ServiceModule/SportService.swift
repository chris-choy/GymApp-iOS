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
    
    func createSport(sport: Data, mode: SaveMode, completion:@escaping (Result < () ,Error>) -> ()){
        
        let suffix = (mode == .create) ? "create" : "update"
        
        let url = URL(string: ConfigConstant.serverAdderss + "/sport/\(suffix)")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer \(id_token)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = sport
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let response = response as? HTTPURLResponse,
                  error == nil else {
                      // check for fundamental networking error
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
            
            // Do with the result.
            completion(.success(()))
            
        }.resume()
        
    }
    
    func getAllSports(completion: @escaping (Result < () ,Error>) -> ()){
        
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
            
            // Do with the result.
            DispatchQueue.main.async {
                self.syncToCoreData(data: data)
            }
            
            // 4. Check the plan data in CoreData if it needs to update after sport data updated.
//            PlanService.shared.getAllPlans { res in
//                switch(res){
//                case .success(()):
//                    break;
//                case .failure(let err):
//                    print(err)
//
//                }
//            }
            
            
            completion(.success(()))
            
            
        }.resume()
        
    }
    
    // #MARK: fileprivate
    fileprivate func syncToCoreData(data: Data){
        do {
            
            let newSports = try JSONDecoder().decode([SportModel].self, from: data)
            
            print(newSports)
            
            
            // 1. Check if they need to be updated.
            let manager = SportDataManager()
            
            // 2. Check if it needs to update the sport data in CoreData.
            let oldSports = manager.fetchAllSport()
            var tags = [Bool](repeating: false, count: oldSports.count)
            
            // 2.1 Clear all the sport if new data array is empty.
            if (newSports.isEmpty) {
                for sport in oldSports {
                    manager.deleteSport(name: sport.name!)
                }
            }
            
            // 2.2 Check every sport in newSports array if it is up-to-date in coredata.
            for sport in newSports {
                
                // 2.2.1 Check the old sport if it is in coredata.
                if let index = oldSports.firstIndex(where: {$0.id == sport.id}){
                    tags[index] = true
                    
                    // 2.2.2 Chcek the sport'name and unit.
                    if((sport.name != oldSports[index].name) || (sport.unit != oldSports[index].unit)){
                        // Update the sport name.
                        manager.updateSport(objectId: oldSports[index].objectID, requestModel: sport)
                    }
                } else {
                    // 2.3 Create the new sport which is not in coredata.
                    _ = manager.createSport(model: sport)
                }
                
            }
            
            // 3. Delete the old sport.
            while true {
                if let index = tags.firstIndex(where: { $0 == false }){
                    tags[index] = true
                    manager.deleteSport(objectId: oldSports[index].objectID)
                } else {
                    break
                }
            }
            
        } catch {
            
            print("SportSerVice.syncToCoreData: \(error)")
        }
    }
    
}
