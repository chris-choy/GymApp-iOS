//
//  GymAppTests.swift
//  GymAppTests
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
@testable import GymApp


//        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))


class GymAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    func testSportModuel(){
        
//        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))

        
        let manager = SportDataManager()
        
        
        
        
//        manager.fetchAllSport()
//         创建运动 name="SportTest" unit="kg"
//        var s = manager.createSport(name: "Sport 1", unit: "kg")
//        s = manager.createSport(name: "Sport 2", unit: "kg")
//        s = manager.createSport(name: "Sport 3", unit: "kg")
        
        
        
//        XCTAssertNotNil(s)
//        XCTAssertEqual(s?.name, "SportTest 3")
        
        
        
        
//        let result = manager.fetchSport(name: "SportTest")
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.name, "SportTest")
        
        
        
        
        
        let result = manager.fetchAllSport()
        XCTAssertNotNil(result)

        print("count = \(result!.count)")

        for item in result! {
            print("\(item.name!) unit=\(item.unit)")
        }
//        XCTAssertEqual(result?.count, 0)
        
        
        // 删除测试
//        manager.deleteSport(name: "Sport 1")
//        manager.deleteSport(name: "Sport 2")
//        manager.deleteSport(name: "Sport 3")
//        let result = manager.fetchAllSport()
//        XCTAssertEqual(result?.count, 0)
        
    }
    
    
    
    
    
    

}
