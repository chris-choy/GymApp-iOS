//
//  PlanCodableTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/7/15.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit
import XCTest

@testable import GymApp


class PlanCodableTest: XCTestCase {
    
    func testfromJsonToPlanModel(){
        
        let result = """
            [ { "id" : 4, "name" : "plan_test_1", "seq" : 1, "user_id" : 4, "sectionList" : [ { "id" : 7, "seq" : 1, "plan_id" : 4, "sport" : { "name" : "sport1", "unit" : "unit1", "id" : 3, "user_id" : 4 }, "rowList" : [ { "id" : 9, "plan_id" : 4, "plan_section_id" : 7, "seq" : 1, "value" : 1111.0, "times" : 11, "restTime" : 2, "lastValue" : 1, "last_changed" : 1626685285000 } ], "last_changed" : 1622627763000 }, { "id" : 8, "seq" : 2, "plan_id" : 4, "sport" : { "name" : "sport2", "unit" : "unit2", "id" : 4, "user_id" : 4 }, "rowList" : [ { "id" : 11, "plan_id" : 4, "plan_section_id" : 8, "seq" : 1, "value" : 333.0, "times" : 33, "restTime" : 4, "lastValue" : 3, "last_changed" : 1626685287000 }, { "id" : 12, "plan_id" : 4, "plan_section_id" : 8, "seq" : 2, "value" : 444.0, "times" : 44, "restTime" : 6, "lastValue" : 5, "last_changed" : 1626685287000 }, { "id" : 13, "plan_id" : 4, "plan_section_id" : 8, "seq" : 3, "value" : 555.0, "times" : 55, "restTime" : 8, "lastValue" : 7, "last_changed" : 1626685289000 } ], "last_changed" : 1622627763000 } ], "last_changed" : 1624527051000 }, { "id" : 26, "name" : "plan_test_2", "seq" : 2, "user_id" : 4, "sectionList" : [ { "id" : 28, "seq" : 1, "plan_id" : 26, "sport" : { "name" : "sport2", "unit" : "unit2", "id" : 4, "user_id" : 4 }, "rowList" : [ { "id" : 31, "plan_id" : 26, "plan_section_id" : 28, "seq" : 1, "value" : 333.0, "times" : 3, "restTime" : 10, "lastValue" : 9, "last_changed" : 1626868823000 }, { "id" : 37, "plan_id" : 26, "plan_section_id" : 28, "seq" : 2, "value" : 555.0, "times" : 5, "restTime" : 12, "lastValue" : 11, "last_changed" : 1626868825000 } ], "last_changed" : 1624610389000 } ], "last_changed" : 1626703085000 } ]
            """
        
        let data = Data(result.utf8)
        
        print("-------------------------testfromJsonToPlanModel-------------------------")
        
//        print(String(data: data, encoding: .utf8)!)

        
        do {
            let plans = try JSONDecoder().decode([PlanModel].self
                                                    , from: data)
//            print(plan)
            
            for plan in plans {
                print(plan)

            }
            
        } catch  {
            print(error.localizedDescription)
        }
        
        print("-------------------------End-------------------------")
        
    }
    
    func testPlanSectionCodable(){
        var result = """
            [{"id":7,"plan_id":4,"rowList":[{"id":9,"plan_section_id":7,"seq":1,"value":11.0,"restTime":1,"lastValue":2,"times":3},{"id":10,"plan_section_id":7,"seq":2,"value":22.0,"restTime":1,"lastValue":2,"times":3}],"seq":1,"sport":{"id":3,"name":"sport1","unit":"unit1","user_id":4}},{"id":8,"plan_id":4,"rowList":[{"id":11,"plan_section_id":8,"seq":1,"value":33.0,"restTime":1,"lastValue":2,"times":3},{"id":12,"plan_section_id":8,"seq":2,"value":44.0,"restTime":1,"lastValue":2,"times":3},{"id":13,"plan_section_id":8,"seq":3,"value":55.0,"restTime":1,"lastValue":2,"times":3}],"seq":2,"sport":{"id":4,"name":"sport2","unit":"unit2","user_id":4}}]
            """
        
        let data = Data(result.utf8)
        
        print("-------------------------testPlanSectionCodable-------------------------")
        
//        print(String(data: data, encoding: .utf8)!)

        
        do {
            let sections = try JSONDecoder().decode([PlanSectionModel].self
                                                    , from: data)
            
            
            for section in sections {
                print(section)

            }
            
        } catch  {
            print(error.localizedDescription)
        }
        
        print("-------------------------End-------------------------")
    }
    
    func testPlanRowCodable(){
        var result = """
            {
                        "id": 9,
                        "plan_id": 4,
                        "plan_section_id": 7,
                        "seq": 1,
                        "value": 1111.0,
                        "times": 11,
                        "restTime": 2,
                        "lastValue": 1,
                        "last_changed": 1626685285000
                      }
            """
        
        let data = Data(result.utf8)
        
        print("-------------------------testPlanSectionCodable-------------------------")
        
        print(String(data: data, encoding: .utf8)!)

        
        do {
            let row = try JSONDecoder().decode(PlanRowModel.self
                                                    , from: data)
            
            print(row)

            
        } catch  {
            print(error.localizedDescription)
        }
        
        print("-------------------------End-------------------------")
    }
    
    func testSportCodable(){
        var result = """
            [ { "name" : "sport1", "unit" : "unit1", "id" : 3, "user_id" : 4, "last_changed" : 1627293361000 }, { "name" : "sport2", "unit" : "unit2", "id" : 4, "user_id" : 4, "last_changed" : 1627293366000 } ]
            """
        
        let data = Data(result.utf8)
        
        print("-------------------------testPlanSectionCodable-------------------------")
        
//        print(String(data: data, encoding: .utf8)!)

        
        do {
            let sport = try JSONDecoder().decode([SportModel].self
                                                    , from: data)
            print(sport)
            
        } catch  {
            print(error.localizedDescription)
        }
        
        print("-------------------------End-------------------------")
    }
    
    func testTimestampToDate(){
        
        let str = """
        {
            "last_changed": "2021-06-24T09:30:51.000+00:00"
        }
        """
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime,
                                   .withFractionalSeconds]
        
        let dd = formatter.date(from: "2021-06-24T09:30:51.000+00:00")
        print(dd)
        
//        if let data = str.data(using: .utf8){
//
//            do {
//                let date = try JSONDecoder().decode(Date.self, from: data)
//                print(date)
//            } catch {
//                print(error)
//            }
//
//
//
//        }
        
        
        
//        let d = try JSONDecoder().decode(Date.self, from: data)
//
//        print(d)
        
    }
    
    
}
