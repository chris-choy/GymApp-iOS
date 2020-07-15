//
//  UnitEntity.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

class SportUnitDataManager {
    var fc: NSFetchedResultsController<SportUnit>?
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
    
    
//    // Fetch.
//    func fetchUnitData() {
//    //        let store = NSPersistentContainer(name: "GymApp")
//    //        store.loadPersistentStores { (desc, err) in
//    //            if let err = err {
//    //                fatalError("core data error: \(err)")
//    //            }
//    //        }
//    //        let context = store.viewContext
//
//        let request : NSFetchRequest<Unit> = Unit.fetchRequest()
//
//        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
//
//        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
//
//        do {
//            try fc?.performFetch()
////            if let object = unitFC?.fetchedObjects {
////                // Do something after readed.
////
////            }
//        } catch  {
//            print(error)
//        }
//
//    }
    
    func fetchAllUnit() -> [SportUnit]?{
        setupContext()

        let request : NSFetchRequest<SportUnit> = NSFetchRequest(entityName: "SportUnit")
        
        do {
            let result = try managedObjectContext?.fetch(request)
            return result
        } catch {
            print("fetchAllUnit Error.")
        }
        
        return nil
    }
    
    
    
    func fetchUnit(name: String) -> SportUnit? {
        setupContext()

        let request : NSFetchRequest<SportUnit> = SportUnit.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try managedObjectContext?.fetch(request)
            
            if(result?.count == 1){
                return result?.first as SportUnit?
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
    
    func isAlreadyExits(name: String) -> Bool{
        
        if (fetchUnit(name: name) != nil){
            print("Error: \"\(name)\" already exists.")
            return true
        }
        
        return false
    }
    
    
    func createUnit(name: String) -> SportUnit?{
        setupContext()
        if !isAlreadyExits(name: name) {
            let unit = NSEntityDescription.insertNewObject(forEntityName: "SportUnit", into: managedObjectContext!) as! SportUnit
            
            unit.name = name
            try! managedObjectContext!.save()
            return unit
        }
        return nil
    }
}
