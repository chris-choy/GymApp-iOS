//
//  SportTagTest.swift
//  GymAppTests
//
//  Created by Chris on 2020/9/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
@testable import GymApp

class SportTagTest: XCTestCase {
    
    func testCreateTag() throws {
        let manager = SportTagDataManager()
        
        let createResult = manager.createTag(name: "tag1")
        
        let fetchResutl = manager.fetchAllTag()
        
        XCTAssertEqual("tag1", createResult?.name)
        
        XCTAssertNotNil(fetchResutl)
    }
    
    func testFetchAllTag() {
        let manager = SportTagDataManager()
        
        let fetchResult = manager.fetchAllTag()
        
        print(fetchResult?.toSportTagModels())
        
    }
    
}
