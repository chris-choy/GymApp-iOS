//
//  PlanModelTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/6/1.
//  Copyright © 2021 Chris. All rights reserved.
//


@testable import GymApp
import XCTest
import CoreData

class PlanModelTest: XCTestCase {
    
    
    func testPlanToPlanModels(){
        
        
        
        
        
    }
    
    
    func testCreatePlanFromPlanModel(){
        var result = """
            {"id":4,"last_changed":1622627763000,"name":"plan1","sectionList":[{"id":7,"plan_id":4,"rowList":[{"id":9,"plan_section_id":7,"seq":1,"value":11.0},{"id":10,"plan_section_id":7,"seq":2,"value":22.0}],"seq":1,"sport":{"id":3,"name":"sport1","unit":"unit1","user_id":4}},{"id":8,"plan_id":4,"rowList":[{"id":11,"plan_section_id":8,"seq":1,"value":33.0},{"id":12,"plan_section_id":8,"seq":2,"value":44.0},{"id":13,"plan_section_id":8,"seq":3,"value":55.0}],"seq":2,"sport":{"id":4,"name":"sport2","unit":"unit2","user_id":4}}],"seq":1,"user_id":4}
            """
        
        let data = Data(result.utf8)
        
        print("-------------------------testfromJsonToPlanModel-------------------------")

        do {
            let planResponseModel = try JSONDecoder().decode(PlanModel.self
                                                    , from: data)

            let manager = PlanCoreDataManager()
            if let planResult = manager.createPlan(model: planResponseModel) {
                let planResultModel = planResult.toPlanModel()
                print(planResultModel)
                XCTAssertTrue(planResultModel.sectionList.count == planResponseModel.sectionList.count)
//                manager.deleteAllPlans()
//                if let all = manager.fetchAllPlans(){
//                    XCTAssertTrue(all.isEmpty)
//                }
                
            }
            
        } catch  {
            print(error.localizedDescription)
        }
        
        print("-------------------------End-------------------------")
    }
    
    
    
    func testUpdatePlan(){
        let manager = PlanCoreDataManager()
        if let result = manager.fetchAllPlans(){
            let plan = result[0]
            let planModel = plan.toPlanModel()
            let resModel = planModel
            
//            let jsonStr = try JSONEncoder().encode(resModel)
            
            do {
                let jsonData = try JSONEncoder().encode(resModel)
                let jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                print(jsonStr)
            } catch {
                print(error)
            }
            
            
        }
        
    }
    
}
