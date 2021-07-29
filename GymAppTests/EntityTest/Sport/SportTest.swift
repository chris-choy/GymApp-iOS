//
//  SportTest.swift
//  GymAppTests
//
//  Created by Chris on 2020/9/28.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
@testable import GymApp

class SportTest: XCTestCase {
    
    func testFetchAllSport(){
        let manager = SportDataManager()
        
        let result = manager.fetchAllSport()
        
        if result == nil {
            print("There are no sport!!!!!!!!!!!!")
            
        } else{
            
            let str = try! JSONEncoder().encode(result?.toSportModels())
            
            
            print(String.init(data: str, encoding: .utf8))
        }

    }
    
    func testCreateSport(){
        let manager = SportDataManager()
        let result = manager.createSport(name: "sport1", unit: "unit1")
        
        XCTAssertNotNil(result)
    }
}
