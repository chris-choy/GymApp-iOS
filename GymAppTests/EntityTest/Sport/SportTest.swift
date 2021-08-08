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
    
//    func testSportCodable(){
//        
//        let str = ""
//        
//        do {
//            let plans = try JSONDecoder().decode([PlanModel].self
//                                                    , from: data)
////            print(plan)
//            
//            for plan in plans {
//                print(plan)
//
//            }
//            
//        } catch  {
//            print(error.localizedDescription)
//        }
//        
//        print("-------------------------End-------------------------")
//    }
}
