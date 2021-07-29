//
//  RecordRowTest.swift
//  GymAppTests
//
//  Created by Chris on 2020/11/30.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
@testable import GymApp

class RecordRowTest: XCTestCase {
    
    func getPlan() -> PlanModel? {
        let manager = PlanCoreDataManager()
        if let resutl = manager.fetchAllPlans() {
            if resutl.count > 0 {
                return resutl[0].toPlanModel()
            }
        }
        
        return nil
        
    }

    func testCreateRow(){
        let manager = RecordRowCoreDataManager()
        
        if let plan = getPlan() {
            if plan.sectionList.count > 0 {
                // 测试时只创建第一个section的记录
                let rowList = plan.sectionList[0].rowList
                var num = 1 // 利用costTime测试是否按顺序。
                for r in rowList {
//                    print("costTime: \(num), times: \(r.times), value: \(r.value)")
                    
                    manager.create(costTime: num, times: r.times, value: r.value)
                    num += 1
                }
                
            }
        }
    }
    
    func testFetchAll(){
        let manager = RecordRowCoreDataManager()
        
        
        
        var count = 0
        
        
        if let result = manager.fetchAll() {
            print("---------------------------------------")
            print("总共：\(result.count)")
            print("---------------------------------------")
            for r in result {
                count += 1
                print("\(count): costTime=\(r.costTime),times=\(r.times),value=\(r.value)")
            }
        }
        
        
//        print(result?.toRecordRowModels())
    }

}


