//
//  SportModuleEntity.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

struct SportModel {
    var name: String
    var unit: SportUnitModel
}

extension Sport{
    func toSportModel() -> SportModel{
        let model = SportModel(
            name: self.name!,
            unit: (self.unit?.toSportUnitModel())!
        )

        return model
    }
}

extension Array where Element == Sport {
    func toSportModels() -> [SportModel]{
        
        var models:[SportModel] = []
        for sport in self{
            models.append(sport.toSportModel())
        }
        
        return models
    }
}

class SportDataManager {
    var fc: NSFetchedResultsController<Sport>?
    let managedObjectContext = CoreDataManagedContext.sharedInstance.managedObjectContext

//    func setupContext(){
//        if(managedObjectContext == nil){
//            let container = NSPersistentContainer(name: "GymApp")
//            container.loadPersistentStores { (desc, err) in
//                if let err = err {
//                    fatalError("core data error: \(err)")
//                }
//            }
//            managedObjectContext = container.viewContext
//        }
//    }
    
    
    func fetchAllSport() -> [Sport]?{
        
        
        let request : NSFetchRequest<Sport> = NSFetchRequest(entityName: "Sport")
        
        do {
            let result = try managedObjectContext.fetch(request)
            
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func fetchSport(name: String) -> Sport? {

        let request : NSFetchRequest<Sport> = Sport.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try managedObjectContext.fetch(request)
            
            switch result.count {
            case 1:
                return result.first as Sport?
            case 0:
//                print("Not exist.")
                // Not exist.
                return nil
            default:
                print("Error: More than one object existed.")
                return nil
            }
            
        } catch {
            print("Failed.")
        }
        
        
        return nil
    }
    
    
    func createSport(name: String, unit: String) -> Sport?{
//        setupContext()
//        let context = CoreDataManagedContext.sharedInstance.managedObjectContext
        
        if (fetchSport(name: name) != nil){
            print("Error: \"\(name)\" is already existed.")
            return nil
        }
        
        let sport = NSEntityDescription.insertNewObject(forEntityName: "Sport", into: managedObjectContext) as! Sport
        sport.name = name
        
        if let u = SportUnitDataManager().fetchUnit(name: unit) {
            sport.unit = u
            try! managedObjectContext.save()
            return sport
        } else {
            print("The unit \"\(name)\" is not existed.")
            return nil
        }

//        try! context.save()
        
        
        
    }
    
    func deleteSport(name: String) {
        
        
        if let sport = fetchSport(name: name) {
            managedObjectContext.delete(sport)
            try! managedObjectContext.save()
            print("done")
        } else {
            print("Can't find the sport.")
        }
        
        
    }
}
