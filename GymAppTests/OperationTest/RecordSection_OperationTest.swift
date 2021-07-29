//
//  RecordSection_OperationTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/1/24.
//  Copyright © 2021 Chris. All rights reserved.
//

import XCTest
@testable import GymApp

class RecordSection_OperationTest: XCTestCase {

    func testFetchAllRecordSection(){
        
        let manager = RecordSectionCoreDataManager()
        
        if let result = manager.fetchAll() {
            print("---------------------------------------------------------------------------")
            
            print("count = \(result.count)")
            
            if(result.count != 0) {
                print(result)
            }
            
            print("---------------------------------------------------------------------------")
        }
    }
    
    func testCreateRecordSection(){
        print("---------------------------------------------------------------------------")
        
        // 1. 检查是否有对应的Record存在
        let recordManager = RecordCoreDataManager()
        let recordResult = recordManager.fetchAllRecords()
        
        XCTAssert(recordResult.count > 0, "Error：当前还没有创建Section。")
        
        // 2. 绑定Record对应的Plan中的Sport
        var sportName = ""
        if let planModel = recordResult.first?.plan?.toPlanModel() {
            sportName = planModel.sectionList[0].sport.name
        }
        
        XCTAssert(sportName.isEmpty == false, "Error：没有找到对应的Sport名字")
        
        // 3. 创建RecrodSection
        let sectionManager = RecordSectionCoreDataManager()
        
        let sectionResult = sectionManager.create(sportName: sportName, record: recordResult[0])
        
        XCTAssertNotNil(sectionResult, "Error：创建失败。")
        
        print("创建成功。")
        print(sectionResult)
        
        print("---------------------------------------------------------------------------")
    }
}
