//
//  RecordTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/2/21.
//  Copyright © 2021 Chris. All rights reserved.
//

import XCTest
@testable import GymApp

class RecordTest: XCTestCase {

    func testFetchAll(){
        let manager = RecordCoreDataManager()
        
        
        
        var count = 0
        
        
        let result = manager.fetchAllRecords()
        
        print("---------------------------------------")
        print("总共：\(result.count)")
        print("---------------------------------------")
        for r in result {
            count += 1
            print("\(count):")
            print(r.toRecordModel())
//                print("\(count): costTime=\(r.costTime),times=\(r.times),value=\(r.value)")
//            print(r)
        }
        
        
        
//        print(result?.toRecordRowModels())
    }
    
    func testCreateRecordWithModel(){
        // 创建model
        
        let sectionModel1 = RecordSectionModel(sportName: "sport1", sportUnit: "unit1", recordRowList: [
            RecordRowModel(costTime: 4, times: 8, value: 15),
            RecordRowModel(costTime: 2, times: 8, value: 16),
            RecordRowModel(costTime: 3, times: 8, value: 15),
            RecordRowModel(costTime: 2, times: 8, value: 16)
        ])
        
        let sectionModel2 = RecordSectionModel(sportName: "sport2", sportUnit: "unit2", recordRowList: [
            RecordRowModel(costTime: 5, times: 8, value: 5),
            RecordRowModel(costTime: 1, times: 10, value: 5)
            
        ])
        
        let recordModel = RecordModel(planName: "Plan1", date: Date(), totalTime: 25, recordSectionList: [sectionModel1,sectionModel2])
        
        //
        let manager = RecordCoreDataManager()
        if let result = manager.createRecord(model: recordModel){
            
            print("---------------------------------Result---------------------------------")
            print(result)
            
            
            print("---------------------------------Result---------------------------------")
        } else {
            print("ffffffffffffff!")
        }
    }
    
    
    
    
}
