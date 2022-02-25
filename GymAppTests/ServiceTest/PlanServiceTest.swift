//
//  PlanServiceTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/7/19.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit
import XCTest

@testable import GymApp
class PlanServiceTest: XCTestCase {

    func testGetAllPlan(){
        
        
        print("------------------------------testGetAllPlan------------------------------")
        
        let exp = expectation(description: "")
        
        // 登陆,获取jwt.
//        UserService.shared.signIn(username: "user1", password: "password1"){
//            res in
//            switch(res){
//            case .success(let jwt):
//                UserDefaults.standard.setValue(jwt.id_token, forKey: "id_token")
//                UserDefaults.standard.synchronize()
//
//
//                print("success:\(jwt.id_token)")
//
//                exp.fulfill()
//
//            case .failure(let err):
//                print("failure:!!!!!")
//                print(err)
//                exp.fulfill()
//            }
//        }
        
        
        
        // 进行操作.
        
        PlanService.shared.getAllPlans { res in
            switch(res){
            case .success(_):
                print(" ")
                
                
                // Convert the result to PlanResponseModel.
//                do {
//                    let plansResponse = try JSONDecoder().decode([PlanModel].self, from: data)
//                    print(plansResponse)
//
//                    exp.fulfill()
//
//                } catch  {
//                    print(error.localizedDescription)
//                }
                
            case .failure(let err):
                print("error")
                print(err)
                exp.fulfill()
                
            }
        }
        
//        waitForExpectations(timeout: 10, handler: nil)
        
        print("------------------------------testGetAllPlan------------------------------")
    }
    
}
