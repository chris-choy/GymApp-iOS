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
struct PlanModel {
    let objectId : NSManagedObjectID?
    var name : String
    var sectionList: [PlanSectionModel] = []
}


// #MARK: CoreData
class PlanCoreDataManager {
    var planFC: NSFetchedResultsController<Plan>?
    var managedObjectContext: NSManagedObjectContext?
    let context = CoreDataManagedContext.sharedInstance.managedObjectContext

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
    
    func fetchPlan(id: NSManagedObjectID) -> Plan? {
        do {
            let result = try context.existingObject(with: id) as! Plan
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func fetchPlan(name: String) -> Plan? {        
//        setupContext()
        
        let request : NSFetchRequest<Plan> = Plan.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try context.fetch(request)
            
            if(result.count == 1){
                return result.first as Plan?
            }
            if(result.count == 0){
                print("Error: \(name) is not existed")
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
    
    func updatePlan(plan: PlanModel) -> Bool{
        
        let sectionManager = PlanSectionCoreDataManager()
        
        if let p = fetchPlan(id: plan.objectId!) {
            // Update the name.
            p.name = plan.name
            
            // Update the sections.
            // Clear the planSections.
            if p.planSections?.count != 0{
                if let secitons = p.planSections as? Set<PlanSection> {
                    for section in secitons {
                        section.delete()
                    }
                    
                    // Clear the planSections.
                    p.planSections = []
                }
            }
            
            // Create section object and relate to them.
            if p.planSections?.count == 0 {
                for sectionModel in plan.sectionList{
                    if let section = sectionManager.createPlanSection(model: sectionModel){
                        p.addToPlanSections(section)
                    }
                }
                
            } else {
                print("Error: PlanSection create failed.")
            }
            
            // Save.
            do {
                try context.save()
            } catch let err {
                print(err)
                return false
            }
            return true
        } else {
            print("Error: \"\(plan.name)\" is not existed.")
            return false
        }
    }
}

extension Plan{
    func toPlanModel() -> PlanModel{
        
        let sectionArray = self.planSections!.allObjects as! [PlanSection]
        
        
        let model = PlanModel(
            objectId: self.objectID,
            name: self.name!,
            sectionList: sectionArray.toPlanSectionModels()
        )

        return model
    }
}




