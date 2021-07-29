//
//  RecordSectionTest.swift
//  GymAppTests
//
//  Created by Chris on 2020/11/30.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
@testable import GymApp


class RecordSectionTest: XCTestCase {
    func getSport() -> [Sport]? {
        let manager = SportDataManager()
        
        let result = manager.fetchAllSport()
        
        return result
    }
    
    func getRecorRows() -> [RecordRow]? {
        let manager = RecordRowCoreDataManager()
        
        let result = manager.fetchAll()
        
        return result
    }

    func testCreateSection(){
        let manager = RecordSectionCoreDataManager()
        
        /*
        if let sportList = getSport() {
            print(sportList.toSportModels())
        }
        
        if let rowList = getRecorRows() {
            print(rowList.toRecordRowModels())
        }
        */
        
        /*
        let sportList = getSport()
        let rowList = getRecorRows()
        
        if (sportList != nil && rowList != nil) {
            let result = manager.create(sportName: sportList![0].name!, rowList: rowList!)
            XCTAssertNotNil(result)
            print("Success!")
            print(result)
        }*/
    }
    
    func testFetchAllRecordSections(){
        
        let manager = RecordSectionCoreDataManager()
        
        if let result = manager.fetchAll(){
            print("总过=\(result.count)")
            
            for r in result {
                print(r)
            }
        } else {
            print("没有RecordSection。")
        }

    }

}
