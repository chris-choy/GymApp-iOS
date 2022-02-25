//
//  RecordServiceTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/11/28.
//  Copyright © 2021 Chris. All rights reserved.
//

import XCTest


@testable import GymApp
class RecordServiceTest: XCTestCase {

    func testToJson(){
        
        if let records = RecordCoreDataManager().fetchAllRecords()?.toRecordModels() {
            do {
                
                let json = try JSONEncoder().encode(records)
                
                print(String.init(data: json, encoding: .utf8))
            } catch {
                print(error)
            }
        }
        
    }
    
    func testDate(){
        
//        let json = 1634054400000
    
        
        let date = Date(timeIntervalSince1970: 1634054400)
        
        
        let nsdate = NSDate(timeIntervalSince1970: 1634054400000)
        
        let dfm = DateFormatter()
        dfm.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
        
        if #available(iOS 15.0, *) {
            print(date.formatted(.dateTime))
            
        } else {
            // Fallback on earlier versions
        }
        
    
        
    }
    
    func testModelFromJson(){
        print("----------------------testModelFromJson---------------------------")
        let json = """
        [{"id":1,"plan_name":"planname1","date":1634054400000,"user_id":0,"recordSectionList":[{"id":2,"rowList":[{"record_section_id":2,"cost_time":7,"value":11.0,"times":5,"date":null},{"record_section_id":2,"cost_time":8,"value":22.0,"times":6,"date":null}],"sport_name":"s1","sport_unit":"u1"},{"id":5,"rowList":[{"record_section_id":5,"cost_time":0,"value":33.0,"times":9,"date":null}],"sport_name":"s2","sport_unit":"u2"}]},{"id":7,"plan_name":"planname2","date":1634054400000,"user_id":0,"recordSectionList":[{"id":8,"rowList":[{"record_section_id":8,"cost_time":9,"value":3.0,"times":1,"date":null},{"record_section_id":8,"cost_time":10,"value":4.0,"times":6,"date":null}],"sport_name":"s3","sport_unit":"s3"}]},{"id":47,"plan_name":"create1","date":1634140860000,"user_id":0,"recordSectionList":[{"id":48,"rowList":[{"record_section_id":48,"cost_time":111,"value":11.0,"times":11,"date":null},{"record_section_id":48,"cost_time":1212,"value":12.0,"times":12,"date":null}],"sport_name":"s1","sport_unit":"u1"},{"id":51,"rowList":[{"record_section_id":51,"cost_time":2121,"value":21.0,"times":21,"date":null}],"sport_name":"s2","sport_unit":"u2"}]}]
        """
        
        let data = Data(json.utf8)
        
        
        do {
            
            let model = try JSONDecoder().decode([RecordModel].self, from: data)
            
            print(model)
        } catch {
            print(error)
        }
        
        print("----------------------testModelFromJson---------------------------")
    }
    
    func testFetchFromDB(){
        
        print("------------------------------------------------------------")
        
        let exp = expectation(description: "")
        
        RecordService.shared.getAllRecords { res in
            switch(res){
            case .success(_):
                
                
                
                if let r = RecordCoreDataManager().fetchAllRecords(){
                    print(r.toRecordModels())
                }
                exp.fulfill()
            case .failure(let err):
                print(err)
                exp.fulfill()
                
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
        
        print("------------------------------------------------------------")
        
    }

}
