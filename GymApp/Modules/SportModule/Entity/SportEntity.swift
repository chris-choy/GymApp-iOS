//
//  SportModuleEntity.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

class SportDataManager {
    var fc: NSFetchedResultsController<Sport>?
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
//    func fetchSportData() {
//    //        let store = NSPersistentContainer(name: "GymApp")
//    //        store.loadPersistentStores { (desc, err) in
//    //            if let err = err {
//    //                fatalError("core data error: \(err)")
//    //            }
//    //        }
//    //        let context = store.viewContext
//
//        let request : NSFetchRequest<Sport> = Sport.fetchRequest()
//
//        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
//
//        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
//
//        do {
//            try fc?.performFetch()
////            if let object = sportFC?.fetchedObjects {
////                // Do something after readed.
////
////            }
//        } catch  {
//            print(error)
//        }
//
//    }
    
    func fetchAllSport() -> [Sport]?{
        setupContext()

        let request : NSFetchRequest<Sport> = NSFetchRequest(entityName: "Sport")
        
        do {
            let result = try managedObjectContext?.fetch(request)
            
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func fetchSport(name: String) -> Sport? {
        setupContext()

        let request : NSFetchRequest<Sport> = Sport.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try managedObjectContext?.fetch(request)
            
            if(result?.count == 1){
                return result?.first as Sport?
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
    
    
    func createSport(name: String, unit: String) -> Sport?{
        setupContext()
        
        if (fetchSport(name: name) != nil){
            print("Error: \"\(name)\" is already existed.")
            return nil
        }
        
        let sport = NSEntityDescription.insertNewObject(forEntityName: "Sport", into: managedObjectContext!) as! Sport
        sport.name = name
        
        if let u = SportUnitDataManager().fetchUnit(name: name) {
            sport.unit = u
        } else {
            print("The unit \"\(name)\" is not existed.")
        }

        try! managedObjectContext!.save()
        
        return sport
        
    }
}
