//
//  RecordTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/2/21.
//  Copyright © 2021 Chris. All rights reserved.
//

import XCTest
import CoreData
@testable import GymApp

class RecordTest: XCTestCase {

    func testFetchAll(){
        let manager = RecordCoreDataManager()
        
        
        
        var count = 0
        
        
        if let result = manager.fetchAllRecords(){
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
        }
        

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
        
        let recordModel = RecordModel(id: 0, planName: "Plan1", date: Date(), totalTime: 25, recordSectionList: [sectionModel1,sectionModel2])
        
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
    
    func testDeleteAllRecords(){
        let fetchPlanRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Record")
        let deletePlanRequest = NSBatchDeleteRequest(fetchRequest: fetchPlanRequest)
        
        let planSectionRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RecordSection")
        let deleteSectionRequest = NSBatchDeleteRequest(fetchRequest: planSectionRequest)
        
        let planRowRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RecordRow")
        let deleteRowRequest = NSBatchDeleteRequest(fetchRequest: planRowRequest)

        do {
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deletePlanRequest)
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deleteSectionRequest)
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deleteRowRequest)

//            try myPersistentStoreCoordinator.execute(deleteRequest, with: CoreDataManagedContext.sharedInstance.managedObjectContext)
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
    
    func testCreateRecordFromJson(){
        print("----------------------testModelFromJson---------------------------")
        let json = """
        [{"id":1,"plan_name":"planname1","date":1634054400000,"user_id":0,"recordSectionList":[{"id":2,"rowList":[{"record_section_id":2,"cost_time":7,"value":11.0,"times":5,"date":null},{"record_section_id":2,"cost_time":8,"value":22.0,"times":6,"date":null}],"sport_name":"s1","sport_unit":"u1"},{"id":5,"rowList":[{"record_section_id":5,"cost_time":0,"value":33.0,"times":9,"date":null}],"sport_name":"s2","sport_unit":"u2"}]},{"id":7,"plan_name":"planname2","date":1634054400000,"user_id":0,"recordSectionList":[{"id":8,"rowList":[{"record_section_id":8,"cost_time":9,"value":3.0,"times":1,"date":null},{"record_section_id":8,"cost_time":10,"value":4.0,"times":6,"date":null}],"sport_name":"s3","sport_unit":"s3"}]},{"id":47,"plan_name":"create1","date":1634140860000,"user_id":0,"recordSectionList":[{"id":48,"rowList":[{"record_section_id":48,"cost_time":111,"value":11.0,"times":11,"date":null},{"record_section_id":48,"cost_time":1212,"value":12.0,"times":12,"date":null}],"sport_name":"s1","sport_unit":"u1"},{"id":51,"rowList":[{"record_section_id":51,"cost_time":2121,"value":21.0,"times":21,"date":null}],"sport_name":"s2","sport_unit":"u2"}]}]
        """
        
        let data = Data(json.utf8)
        
        
        do {
            
            let model = try JSONDecoder().decode([RecordModel].self, from: data)
            
            
            // Create Record.
            let manager = RecordCoreDataManager()
            
            for r in model {
                _ = manager.createRecord(model: r)
            }
            
            print(model)
            
            
        
        } catch {
            print(error)
        }
        
        print("----------------------testModelFromJson---------------------------")
    }
    
    func testEncodeRecord(){
        
        let manager = RecordCoreDataManager()
        print("---------------------------------------")

        var count = 0

        if let result = manager.fetchAllRecords(){
            
            print("总共：\(result.count)")
            
            
            do {
                let json = try JSONEncoder().encode(result[0].toRecordModel())
                
                print(String(data: json, encoding: .utf8))
            } catch  {
                print("错误")
                print(error)
            }
            
            
            
            
        }
        
        print("---------------------------------------")
        
    }
    
    
    
    
}
