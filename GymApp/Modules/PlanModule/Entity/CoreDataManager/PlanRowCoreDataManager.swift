//
//  PlanRowCoreDataManager.swift
//  GymApp
//
//  Created by Chris on 2021/6/1.
//  Copyright © 2021 Chris. All rights reserved.
//

import CoreData

class PlanRowCoreDataManager {
    var planRowFC: NSFetchedResultsController<PlanRow>?
    let managedObjectContext = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    // Fetch.
    func fetchPlanRows() -> NSSet {
        let request : NSFetchRequest<PlanRow> = PlanRow.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "setNum", ascending: false)]
        planRowFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try planRowFC?.performFetch()
            if let object = planRowFC?.fetchedObjects {
                
                // Do something after readed.
                return NSSet(objects: object)
                
            }
        } catch  {
            print(error)
        }
        
        return NSSet()
            
    }
    
    func createPlanRow(row: PlanRowModel) -> PlanRow?{
        
        let planRow = NSEntityDescription.insertNewObject(forEntityName: "PlanRow", into: managedObjectContext) as! PlanRow
        planRow.id = Int16(row.id)
        planRow.seq = Int16(row.seq)
        planRow.lastValue = row.lastValue
        planRow.value = row.value
        planRow.times = Int16(row.times)
        planRow.restTime = Int16(row.restTime)
        planRow.plan_id = Int64(row.plan_id)
        planRow.plan_section_id = Int64(row.plan_section_id)
        planRow.last_changed = Int64(row.last_changed)
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }

        return planRow
    }
}

extension PlanRow {
    func delete() {
        let context = CoreDataManagedContext.sharedInstance.managedObjectContext
        context.delete(self)
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
}

extension Array where Element == PlanRow {
    func toPlanRowModels() -> [PlanRowModel]{
        var set: [PlanRowModel] = []
        for r in self {
            set.append(r.toPlanRowModel())
        }
        
        // Sort by the setNum.
        // Because the CoreData saved the data not in order.
        set.sort(by: {$0.seq < $1.seq})
        
        return set
    }
}

