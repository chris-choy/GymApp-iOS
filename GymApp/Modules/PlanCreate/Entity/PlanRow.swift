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
    
    let lastValue : Float
    let value : Float
    let times: Int
    
}

class PlanRowCoreDataManager {
    var planRowFC: NSFetchedResultsController<PlanRow>?
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
    func fetchPlanRows() -> NSSet {
        setupContext()
        let request : NSFetchRequest<PlanRow> = PlanRow.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "setNum", ascending: false)]
        
        planRowFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
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
    
    func createPlanRow(row: PlanRowModel) -> PlanRow{
        setupContext()
        
        let planRow = NSEntityDescription.insertNewObject(forEntityName: "PlanRow", into: managedObjectContext!) as! PlanRow
        
        planRow.lastValue = row.lastValue
        planRow.value = row.value
        planRow.times = Int16(row.times)
        
        try! managedObjectContext!.save()
        
        return planRow
    }
}
