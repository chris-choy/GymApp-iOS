//
//  PlanSection.swift
//  GymApp
//
//  Created by Chris on 2020/6/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData


struct PlanSectionModel {
    let unit: String
    
    let rowList: [PlanRowModel]?
    
    let sport: SportModel
    
//    init(sectionObject: PlanSection) {
//        unit = "Unit String"
//        if let rows = sectionObject.planRows{
//            rowList = row
//        } else {
//            rowList = nil
//        }
//
//        sport = SportModel(name: "Sport Name", unit: UnitModel(name: Unit Name))
//    }
    
}

class PlanSectionCoreDataManager {
    var planSectionFC: NSFetchedResultsController<PlanSection>?
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
    func fetchPlanSections() {
        setupContext()
        let request : NSFetchRequest<PlanSection> = PlanSection.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "setNum", ascending: false)]
        
        planSectionFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
//        do {
//            try planSectionFC?.performFetch()
//            if let object = planSectionFC?.fetchedObjects {
//                // Do something after readed.
//
//            }
//        } catch  {
//            print(error)
//        }
            
    }
    
    func createPlanSection(sport: Sport, rowList: NSSet?){
        setupContext()
        
        let planSection = NSEntityDescription.insertNewObject(forEntityName: "PlanSection", into: managedObjectContext!) as! PlanSection
        
        // Do something with planSection object.
        planSection.sport = sport
        
        if(rowList != nil){
            planSection.planRows = rowList
        } else {
            planSection.planRows = nil
        }
        
        try! managedObjectContext!.save()
    }
    
    
}
