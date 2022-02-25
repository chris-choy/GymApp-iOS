//
//  Record_OperationTest.swift
//  GymAppTests
//
//  Created by Chris on 2020/12/22.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
@testable import GymApp

class Record_OperationTest: XCTestCase {
    
    func testFetchAllRecord(){
        print("test fetch all")
//        let recordManager = RecordCoreDataManager()
//        
//        
//        var count = 0
//        let result = recordManager.fetchAllRecords()
//        
//        print("---------------------------------------------------------------------------")
//        print("count=\(result!.count)")
//        print("result = \(result)")
//        
//        for r in result! {
//            count += 1
//            print("\(count):\(r.plan?.name)")
//        }
        print("---------------------------------------------------------------------------")
    }

    // 创建第一个记录
    func testCreateFirstRecord() {
        
    /// 1.先创建第一个row
        let rowManager = RecordRowCoreDataManager()
//        let row1 = rowManager.create(costTime: 1, times: 1, value: 1.0)
//        let row2 = rowManager.create(costTime: 2, times: 2, value: 2.0)
        
    /// 2.创建第一个section，将row添加进去
        let sectionManager = RecordSectionCoreDataManager()
        
        // 获取sport
        let sportManager = SportDataManager()
//        let sportResult = sportManager.fetchAllSport()
        var section : RecordSection?
        
//        if sportResult?.count != 0 {
        
        /*
            if let row1=rowManager.create(costTime: 1, times: 1, value: 1.0),
               let row2=rowManager.create(costTime: 2, times: 2, value: 2.0),
               let sportResult=sportManager.fetchAllSport()
            {
                section = sectionManager.create(sportName: sportResult[0].name!, rowList: [row1, row2])
            }
            else
            {
                print("rowList is nil.")
            }
        */
        
        
        /*
         
        // test
        if let row1=rowManager.create(costTime: 1, times: 1, value: 1.0){
            if let row2=rowManager.create(costTime: 2, times: 2, value: 2.0) {
                if let sportResult=sportManager.fetchAllSport() {
                    section = sectionManager.create(sportName: sportResult[0].name!, rowList: [row1, row2])
                }
                else {
                    print("Error: There is no sport to fetch.")
                }
            }
            else {
                print("2")
            }
        } else {
            print("1")
        }
        
         */
           
//        {
//        }
//        else
//        {
//            print("rowList is nil.")
//        }
        // test end.
        
        
        
        
//        } else {
//            print("sport is nil.")
//            return
//        }
        
    
        if section != nil {
    /// 3.创建record，将section添加进去
            let recordManager = RecordCoreDataManager()
            if let record = recordManager.createRecord(planName: "planName_test", recordSection: [section!]) {
                print("success.")
                print(record)
            } else {
                
                print("failed.")
            }
        }
        
        
//        let record = recordManager.create(costTime: 99, times: <#T##Int#>, value: <#T##Float#>)
    }
    
    func testCreateRecordWithoutSection(){
        
        // Get the plan
        let planManager = PlanCoreDataManager()
        
        
        
        // Create the Record.
//        let manager = RecordCoreDataManager()
//        
//        if let plan = planManager.fetchAllPlans()?.first {
//            let recordResult = manager.createRecordWithoutSection(planName: plan.name!)
//            XCTAssertNotNil(recordResult)
//            print(recordResult)
//        }
        
        
        
    }
    
    
    // 添加row记录
    func testAddRow(){
        
    }

}
