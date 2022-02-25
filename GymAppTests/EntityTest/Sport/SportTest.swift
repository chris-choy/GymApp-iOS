//
//  SportTest.swift
//  GymAppTests
//
//  Created by Chris on 2020/9/28.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
import CoreData
@testable import GymApp

class SportTest: XCTestCase {
    
    func testDeleteAllSport(){
        let fetchPlanRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Sport")
        let deletePlanRequest = NSBatchDeleteRequest(fetchRequest: fetchPlanRequest)
        
        let planSectionRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SportTag")
        let deleteSectionRequest = NSBatchDeleteRequest(fetchRequest: planSectionRequest)
//
//        let planRowRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlanRow")
//        let deleteRowRequest = NSBatchDeleteRequest(fetchRequest: planRowRequest)

        do {
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deletePlanRequest)
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deleteSectionRequest)
//            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deleteRowRequest)

//            try myPersistentStoreCoordinator.execute(deleteRequest, with: CoreDataManagedContext.sharedInstance.managedObjectContext)
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
    
    func testFetchAllSport(){
        let manager = SportDataManager()
        
        let result = manager.fetchAllSport()
        
        if result.isEmpty {
            print("There are no sport!!!!!!!!!!!!")
            
        } else{
            
            let str = try! JSONEncoder().encode(result.toSportModels())
            
            
            print(String.init(data: str, encoding: .utf8))
        }

    }
    
    func testCreateSport(){
        let manager = SportDataManager()
        let result = manager.createSport(name: "sport1", unit: "unit1")
        
        XCTAssertNotNil(result)
    }
    
    func testDecodeSport(){
        let json = """
                    [{"name":"sport1","unit":"unit1","id":3,"user_id":4,"last_changed":1627293361000},{"name":"sport2","unit":"unit2","id":4,"user_id":4,"last_changed":1627293366000},{"name":"Sport11","unit":"Unit11","id":10,"user_id":4,"last_changed":1628739014000},{"name":"11","unit":"1","id":13,"user_id":4,"last_changed":1629213453000},{"name":"22","unit":"2","id":14,"user_id":4,"last_changed":1629215214000},{"name":"3","unit":"3","id":15,"user_id":4,"last_changed":1629215300000},{"name":"44","unit":"4","id":16,"user_id":4,"last_changed":1629215361000},{"name":"5","unit":"5","id":17,"user_id":4,"last_changed":1629215400000},{"name":"66","unit":"6","id":18,"user_id":4,"last_changed":1629215423000},{"name":"7","unit":"7","id":19,"user_id":4,"last_changed":1629216744000},{"name":"8","unit":"8","id":20,"user_id":4,"last_changed":1629216787000},{"name":"9","unit":"9","id":21,"user_id":4,"last_changed":1629216990000},{"name":"10","unit":"10","id":22,"user_id":4,"last_changed":1629217121000},{"name":"spor55","unit":"unit55","id":27,"user_id":4,"last_changed":1629254814000},{"name":"31","unit":"31","id":28,"user_id":4,"last_changed":1629217535000},{"name":"A1","unit":"A","id":29,"user_id":4,"last_changed":1629217589000},{"name":"B1","unit":"B","id":30,"user_id":4,"last_changed":1629217954000},{"name":"C","unit":"1","id":31,"user_id":4,"last_changed":1629217989000},{"name":"Test133","unit":"Test13","id":32,"user_id":4,"last_changed":1629278997000},{"name":"仰卧起坐","unit":"个","id":33,"user_id":4,"last_changed":1634109596000},{"name":"飞鸟","unit":"kg","id":34,"user_id":4,"last_changed":1634109611000},{"name":"哑铃弯举","unit":"kg","id":35,"user_id":4,"last_changed":1634109643000},{"name":"testcom1","unit":null,"id":37,"user_id":4,"last_changed":1637638431000},{"name":"tt1","unit":"unit","id":40,"user_id":4,"last_changed":1637653686000}]
                    """
        
        if let data = json.data(using: .utf8){
            
            do {
                let sports = try JSONDecoder().decode([SportModel].self, from: data)
                
                print(sports)
                
            } catch {
                print(error)
            }
            
            
            
            
        }
        
        
        
        
        
    }
    

}
