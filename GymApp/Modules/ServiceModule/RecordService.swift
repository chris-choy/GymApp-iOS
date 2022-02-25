//
//  RecordService.swift
//  GymApp
//
//  Created by Chris on 2021/12/2.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation

class RecordService: NSObject{
    
    static let shared = RecordService()
    
    let id_token = UserDefaults.standard.string(forKey: "id_token") as! String
    
    func createRecord(recordData: Data, completion: @escaping (Result< () , Error>) -> ()){
        
        // Set request information.
        let url = URL(string: ConfigConstant.serverAdderss + "/record/create")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setValue("Bearer \(id_token)", forHTTPHeaderField: "Authorization")
        request.httpBody = recordData
        
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
                
                let err = URLError(URLError.Code(rawValue: response.statusCode))
                completion(.failure(err))
                return
            }
            
            // Do with the result.
//            DispatchQueue.main.async {
//                self.syncToCoreData(result: data)
//            }

            completion(.success(()))

        }.resume()
        
    }
    
    func getAllRecords(completion: @escaping (Result< () , Error>) -> ()){
        
        // Set request information.
        let url = URL(string: ConfigConstant.serverAdderss + "/record/all")!
        
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
    
    fileprivate func syncToCoreData(result: Data){
        do {
            // 1. Transfrom result data to RecordModel.
            let newRecords = try JSONDecoder().decode([RecordModel].self, from: result)
            let recordCoredataManager = RecordCoreDataManager()
            
            // 2. To check if it needs to update the data in CoreData.
            if let oldRecords = recordCoredataManager.fetchAllRecords(){
                var tags = [Bool](repeating: false, count: oldRecords.count)
                
                // 2.1 Clear all the records in the Coredata if the new records array is empty.
                if newRecords.count == 0 {
                    for record in oldRecords {
                        recordCoredataManager.deleteRecord(id: record.objectID)
                    }
                } else {
                    
                    // 2.2 Check the record in coredata.
                    for record in newRecords {
                        if let index = oldRecords.firstIndex(where: { $0.id == record.id}){
                            tags[index] = true
                        } else {
                            // 2.2.1 Add the new record into coredata.
                            _ = recordCoredataManager.createRecord(model: record)
                        }
                        
                        // 2.2.2 Delete the record in coredata but not in result.
                        while true {
                            if let del = tags.firstIndex(where: { $0 == false }){
                                tags[del] = true
                                recordCoredataManager.deleteRecord(id: oldRecords[del].objectID)
                            } else {
                                break
                            }
                        }
                    }
                }
            }
            
        } catch  {
            
            print("RecordService.syncToCoreData: " + error.localizedDescription)
        }
    }
    
    
}
