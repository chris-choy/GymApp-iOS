//
//  PlanCreateEntity.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

// #MARK: Model
//struct PlanModel {
//
//    let name : String
//    let sectionList: [PlanSectionModel]?
//}


// #MARK: CoreData
class PlanCoreDataManager {
    var planFC: NSFetchedResultsController<Plan>?
    var managedObjectContext: NSManagedObjectContext?

    func setupContext(){
        if(managedObjectContext == nil){
            let container = NSPersistentContainer(name: "GymApp")
            container.loadPersistentStores { (desc, err) in
                if let err = err {
                    fatalError("core data error: \(err)")
                }
            }
            managedObjectContext = container.viewContext
        }
    }
    
    
    // Fetch.
    func fetchAllPlans() -> [Plan]? {
        setupContext()
            
        let request : NSFetchRequest<Plan> = Plan.fetchRequest()
        
        do {
            if let result = try managedObjectContext?.fetch(request){
                return result
            }
            
        } catch  {
            print(error)
        }
        
        return nil
    }
    
    func fetchPlan(name: String) -> Plan? {        
        setupContext()

        let request : NSFetchRequest<Plan> = Plan.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try managedObjectContext?.fetch(request)
            
            if(result?.count == 1){
                return result?.first as Plan?
            }
            else {
                print("Error: More than one object existed.")
                
                return nil
            }
            
        } catch {
            print("Failed.")
        }
        
        
        return nil
    }
    
    
    func createPlan(name: String, sectionList: NSSet?) -> Plan?{
        setupContext()
        
        if (fetchPlan(name: name) != nil){
            print("Error: \"\(name)\" already exists.")
            return nil
        }
        
        let plan = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: managedObjectContext!) as! Plan
        plan.name = name
        
        if let sectionList = sectionList {
            plan.addToPlanSections(sectionList)
        }

        try! managedObjectContext!.save()
        
        return plan
        
    }
}



