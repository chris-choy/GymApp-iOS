//
//  PlanCoreDataManager.swift
//  GymApp
//
//  Created by Chris on 2021/6/1.
//  Copyright © 2021 Chris. All rights reserved.
//

import CoreData

class PlanCoreDataManager {

    let context = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    // Fetch.
    func fetchAllPlans() -> [Plan]? {
            
        let request : NSFetchRequest<Plan> = Plan.fetchRequest()
        
        do {
            var result = try context.fetch(request)
            
            // Plans are sorted by seq.
            result.sort(by: {$0.seq < $1.seq })
            
            return result
            
        } catch  {
            print(error)
        }
        
        return nil
    }
    
    func fetchPlan(objectId: NSManagedObjectID) -> Plan? {
        do {
            let result = try context.existingObject(with: objectId) as! Plan
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
//    func fetchPlan(id: Int) -> Plan? {
//        do {
//            let result = try context.existingObject(with: objectId) as! Plan
//            return result
//        } catch {
//            print(error)
//        }
//        return nil
//    }
    
    func fetchPlan(name: String) -> Plan? {

        let request : NSFetchRequest<Plan> = Plan.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try context.fetch(request)
            
            if(result.count == 1){
                return result.first as Plan?
            }
            if(result.count == 0){
                print("\(name) is not existed")
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
    
    func fetchPlan(id: Int) -> Plan? {

        let request : NSFetchRequest<Plan> = Plan.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            let result = try context.fetch(request)
            
            if(result.count == 1){
                return result.first as Plan?
            }
            if(result.count == 0){
                print("Error: \(id) is not existed")
            }
            else {
                print("Error: More than one object existed.")
                
                return nil
            }
            
        } catch {
//            print("Failed.")
            print(error)
            
        }
        
        return nil
    }
    
    func deleteAllPlans(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Plan")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        let context = CoreDataManagedContext.sharedInstance.managedObjectContext
        do {
            try context.execute(deleteRequest)
            
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
    
    
    func createPlan(name: String, sectionList: NSSet?) -> Plan?{
        
        if (fetchPlan(name: name) != nil){
            print("Error: \"\(name)\" already exists.")
            return nil
        }
        
        let plan = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: context) as! Plan
        plan.name = name
        
        if let sectionList = sectionList {
            plan.addToPlanSections(sectionList)
        }


        do {
            try context.save()
            return plan
        } catch let err {
            print(err)
            return nil
        }
        
    }
    
    func createPlan(model: PlanModel) -> Plan?{
        
        // Check if it already exists.
        if (fetchPlan(name: model.name) != nil){
            print("Error: \"\(model.name)\" already exists.")
            return nil
        }
        
        let planObject = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: context) as! Plan
        planObject.name = model.name
        planObject.id = Int64(model.id)
        planObject.last_changed = Int64(model.last_changed)
        planObject.seq = Int16(model.seq)
        planObject.user_id = Int64(model.user_id)
        
        
        // Create the section list.
        for sectionModel in model.sectionList{
            let sectionObject = createSection(model: sectionModel)
            
            for rowModel in sectionModel.rowList {
                sectionObject.addToPlanRows(createRow(rowModel: rowModel))
            }
            
            planObject.addToPlanSections(sectionObject)
        }
//        planObject.planSections?.allObjects
        
        do {
            try context.save()
            return planObject
        } catch let err {
            print(err)
            print(planObject)
            return nil
        }

    }
    
    private func createRow(rowModel: PlanRowModel) -> PlanRow {
        let planRow = NSEntityDescription.insertNewObject(forEntityName: "PlanRow", into: context) as! PlanRow
        planRow.id = Int16(rowModel.id)
        planRow.seq = Int16(rowModel.seq)
        planRow.lastValue = rowModel.lastValue
        planRow.value = rowModel.value
        planRow.times = Int16(rowModel.times)
        planRow.restTime = Int16(rowModel.restTime)
        planRow.plan_id = Int64(rowModel.plan_id)
        planRow.plan_section_id = Int64(rowModel.plan_section_id)
        planRow.last_changed = Int64(rowModel.last_changed)
        return planRow
    }
    
    
    private func createSection(model: PlanSectionModel) -> PlanSection {
        let planSection = NSEntityDescription.insertNewObject(forEntityName: "PlanSection", into: context) as! PlanSection
        planSection.seq = model.seq
        planSection.id = Int32(model.id)
        planSection.plan_id = Int64(model.plan_id)
        planSection.last_changed = Int64(model.last_changed)
        
        
        // Relate to Sport.
        planSection.sport = fetchOrCreateSport(model: model.sport)
        
        
        return planSection
    }
    
    
    private func fetchOrCreateSport(model: SportModel) -> Sport {
        // Relate to Sport.
        let sportManager = SportDataManager()
        if let sport = sportManager.fetchSport(name: model.name){
            return sport
        } else {
            // Create
            let sport = NSEntityDescription.insertNewObject(forEntityName: "Sport", into: context) as! Sport
            sport.name = model.name
            sport.id = Int32(model.id)
            sport.user_id = Int64(model.user_id)
            return sport
        }

    }
    
    
    
    func createPlan_bak(model: PlanModel) -> Plan?{
        

        let sectionManager = PlanSectionCoreDataManager()
        
        
        // Check if it already exists.
        if (fetchPlan(name: model.name) != nil){
            print("Error: \"\(model.name)\" already exists.")
            return nil
        }
        
        let planObject = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: context) as! Plan
        planObject.name = model.name
        planObject.id = Int64(model.id)
        planObject.last_changed = Int64(model.last_changed)
        planObject.seq = Int16(model.seq)
        planObject.user_id = Int64(model.user_id)
        
        
        // Create the section list.
        for sectionModel in model.sectionList{
            
            if let section = sectionManager.createPlanSection(model: sectionModel){
                planObject.addToPlanSections(section)
            } else {
                print("error in create ")
            }
            
        }
        
        do {
            try context.save()
            return planObject
        } catch let err {
            print(err)
            return nil
        }

    }
    
    
    
    func updatePlan(plan: PlanModel) -> Bool{
        
        let sectionManager = PlanSectionCoreDataManager()
        
        if let p = fetchPlan(objectId: plan.objectId!) {
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
            print("Error in (updatePlan) that \"\(plan.name)\" is not existed.")
            return false
        }
    }
    
    func deletePlan(id: NSManagedObjectID){
        
        do {
            if let plan = try context.existingObject(with: id) as? Plan{
                
                if let sectionList = plan.planSections?.allObjects as? [PlanSection] {
                    for section in sectionList {
                        // Delete sections.
                        if let rowList = section.planRows?.allObjects as? [PlanRow] {
                            for row in rowList{
                                // Delete rows.
                                context.delete(row)
                            }
                        }
                        context.delete(section)
                    }
                }
                context.delete(plan)
                try context.save()
            }
            
        } catch {
            print(error)
        }
    }
    
}

extension Plan{
    func toPlanModel() -> PlanModel{
        
        let sectionArray = self.planSections!.allObjects as! [PlanSection]
        
        let model = PlanModel(
            id: Int(self.id),
            objectId: self.objectID,
            name: self.name!,
            sectionList: sectionArray.toPlanSectionModels(),
            last_changed: Int(self.last_changed),
            seq: Int(seq),
            user_id: Int(user_id)
        )

        return model
    }
}
