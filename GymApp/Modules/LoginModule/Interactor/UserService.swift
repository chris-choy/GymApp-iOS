//
//  UserService.swift
//  GymApp
//
//  Created by Chris on 2021/5/25.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation

class UserService: NSObject {
    static let shared = UserService()
    
    func signIn(username:String, password:String, completion: @escaping (Result< Jwt , Error>) -> ()){
        
        // Set request information.
        let url = URL(string: "\(ConfigConstant.serverAdderss)/api/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let body = ["username": username, "password": password]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
           let jsonText = String(data: jsonData, encoding: .utf8){
            print(jsonText)

            request.httpBody = jsonData
        }
        
//        URLSession.shared.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        
        
        // Start the request.
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                
                // Check for fundamental networking error.
                print("error", error ?? "Unknown error")
                if let error = error {
                    completion(.failure(error))
                }
                
                return
            }

            guard response.statusCode == 200 else {                    // check for http errors
                print("There is error, status code =  \(response.statusCode)")
                print("response = \(response)")
                
//                completion()
                
                return
            }
            
            // Do with the result.
            let responseString = String(data: data, encoding: .utf8)
            
            do {
                let id_token = try JSONDecoder().decode(Jwt.self,from: data)
                completion(.success(id_token))
            } catch{
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    
    func getProfile(completion: @escaping (Result< User , Error>) -> ()){
        let id_token = UserDefaults.standard.string(forKey: "id_token") as! String
        
        // Set request information.
//        let url = URL(string: "http://localhost:8080/user/a")!
        let url = URL(string: ConfigConstant.serverAdderss + "/user/profile")!
        
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setValue("Bearer \(id_token)", forHTTPHeaderField: "Authorization")
        
        
        
        
//        let body = ["username": username, "password": password]
        
//        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
//           let jsonText = String(data: jsonData, encoding: .utf8){
//            print(jsonText)
//            request.httpBody = jsonData
//        }
        
        // Start the request.
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard response.statusCode == 200 else {                    // check for http errors
                print("There is error, status code =  \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            // Do with the result.
            let responseString = String(data: data, encoding: .utf8)
            
            do {
                let user = try JSONDecoder().decode(User.self,from: data)
                completion(.success(user))
            } catch{
                completion(.failure(error))
            }
            
        }
        
        task.resume()
        
        
        
        
    }
    
}
