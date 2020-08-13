//
//  PlanRowCoreDataManagement.swift
//  GymApp
//
//  Created by Chris on 2020/6/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData


struct PlanRowModel {
    
    let setNum: Int
    let lastValue : Float
    var value : Float
    var times: Int
    
}

class PlanRowCoreDataManager {
    var planRowFC: NSFetchedResultsController<PlanRow>?
    let managedObjectContext = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    // Fetch.
    func fetchPlanRows() -> NSSet {
//        setupContext()
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
//        setupContext()
        
        let planRow = NSEntityDescription.insertNewObject(forEntityName: "PlanRow", into: managedObjectContext) as! PlanRow
        
        planRow.setNum = Int16(row.setNum)
        planRow.lastValue = row.lastValue
        planRow.value = row.value
        planRow.times = Int16(row.times)
        
        try! managedObjectContext.save()
        
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
    
    func toPlanRowModel() -> PlanRowModel{
        let model = PlanRowModel(
            setNum: Int(self.setNum),
            lastValue: self.lastValue,
            value: self.value,
            times: Int(self.times))
        
        return model
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
        set.sort(by: {$0.setNum < $1.setNum})
        
        return set
    }
}


