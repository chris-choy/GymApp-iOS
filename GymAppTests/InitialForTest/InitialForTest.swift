//
//  InitialForTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/1/13.
//  Copyright © 2021 Chris. All rights reserved.
//

import XCTest
@testable import GymApp

class InitialForTest: XCTestCase {
    
    /*
    
    fileprivate func createUnit1AndUnit2() {
        // 创建单位
        let unitManager = SportUnitDataManager()
        /// 创建unit1
        let unitResult1 = unitManager.createUnit(name: "unit1")
        XCTAssertNotNil(unitResult1)
        /// 创建unit2
        let createResult2 = unitManager.createUnit(name: "unit2")
        XCTAssertNotNil(unitResult1)
    }
    
    fileprivate func createSport1AndSport2() {
        // 创建运动
        let sportManager = SportDataManager()
        /// 创建sport1
        let sportResult1 = sportManager.createSport(name: "sport1", unit: "unit1")
        XCTAssertNotNil(sportResult1)
        ///创建Sport2
        let sportResult2 = sportManager.createSport(name: "sport2", unit: "unit2")
        XCTAssertNotNil(sportResult1)
    }
    
    fileprivate func createPlanWithPlanModelAndRow(){
        var planModel : PlanModel = {
            let row1 = PlanRowModel(id: 0,
                                    seq: 1,
                                    lastValue: 0,
                                    value: 15,
                                    times: 8)
            let row2 = PlanRowModel(id: 0,
                                    seq: 2,
                                    lastValue: 0,
                                    value: 16,
                                    times: 8)
            let row3 = PlanRowModel(id: 0,
                                    seq: 3,
                                    lastValue: 0,
                                    value: 15,
                                    times: 8)
            let row4 = PlanRowModel(id: 0,
                                    seq: 4,
                                    lastValue: 0,
                                    value: 16,
                                    times: 8)
            let section1 = PlanSectionModel(id: 0,
                                            sectionIndex: 0,
                                            unit: "unit1",
                                            rowList: [row1,row2,row3,row4],
                                            sport: SportModel(id: 0,
                                                              name: "sport1",
                                                              unit: SportUnitModel(name: "unit1", sportNames: nil)))
            
            let row5 = PlanRowModel(id: 0,
                                    seq: 1,
                                    lastValue: 0,
                                    value: 5,
                                    times: 8)
            
            let row6 = PlanRowModel(id: 0,
                                    seq: 2,
                                    lastValue: 0,
                                    value: 5,
                                    times: 10)
            
            let section2 = PlanSectionModel(id: 0,
                                            sectionIndex: 1,
                                            unit: "unit2",
                                            rowList: [row5,row6],
                                            sport: SportModel(id: 0,
                                                              name: "sport2",
                                                              unit: SportUnitModel(name: "unit2", sportNames: nil)))
            
            
            
            let sectionList = [section1, section2]
            
            
            let model = PlanModel(
                id: nil,
                objectId: nil,
                name: "Plan1",
                sectionList:sectionList,
                last_changed: 0)
            
            return model
        }()
        
        let planManager = PlanCoreDataManager()

        if let result = planManager.createPlan(plan: planModel) {
            print(result)
            
            print("\n")
            print(result.toPlanModel())
        }
        
    }
    
    
    func testInitialData(){
        
        // 创建单位
        createUnit1AndUnit2()
        
        // 创建运动
        createSport1AndSport2()
        
        
        // 创建计划
        createPlanWithPlanModelAndRow()
    }
 
 */

}
