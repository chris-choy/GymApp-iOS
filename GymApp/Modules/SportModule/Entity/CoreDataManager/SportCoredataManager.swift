//
//  SportCoredataManager.swift
//  GymApp
//
//  Created by Chris on 2021/6/7.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation
import CoreData

class SportDataManager {
    var fc: NSFetchedResultsController<Sport>?
    let managedObjectContext = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    func fetchAllSport() -> [Sport]?{
        
        
        let request : NSFetchRequest<Sport> = NSFetchRequest(entityName: "Sport")
        
        do {
            let result = try managedObjectContext.fetch(request)
            if result.count == 0 {
                return nil
            }
            else{
                return result
            }
            
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
    
    func updateSport(objectId: NSManagedObjectID, requestModel: SportModel){
        do {
            let sport = try managedObjectContext.existingObject(with: objectId) as! Sport
            
            sport.name = requestModel.name
            sport.last_changed = Int64(requestModel.last_changed)
            sport.id = Int32(requestModel.id)
            sport.user_id = Int64(requestModel.user_id)
            
            try managedObjectContext.save()
            
        } catch {
            print(error)
        }

    }
    
    
    func createSport(model: SportModel) -> Sport? {
        

        if (fetchSport(name: model.name) != nil){
            print("Error: \"\(model.name)\" is already existed.")
            return nil
        }

        let sport = NSEntityDescription.insertNewObject(forEntityName: "Sport", into: managedObjectContext) as! Sport
        sport.name = model.name
        sport.id = Int32(model.id)
        sport.user_id = Int64(model.user_id)
//        sport.unit = model.unit
        // 这里还有未完成的unit创建。

        try! managedObjectContext.save()
        
        return sport


    }
    
    
    
    func createSport(name: String, unit: String) -> Sport?{
        
        // Check for sport and unit.
        if (fetchSport(name: name) != nil){
            print("Error: \"\(name)\" is already existed.")
            return nil
        }
        
        var unitObject : SportUnit?
        
        unitObject = SportUnitDataManager().fetchUnit(name: unit)
        
        if unitObject == nil {
            // Create unit.
            unitObject = SportUnitDataManager().createUnit(name: unit)
        }
            
        guard unitObject != nil else {
            print("createSport: error in fetchUnit and createUnit.")
            return nil
        }
        
        // Create Sport
        let sport = NSEntityDescription.insertNewObject(forEntityName: "Sport", into: managedObjectContext) as! Sport
        sport.name = name
        sport.unit = unitObject
        
        try! managedObjectContext.save()
        return sport
        
        
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
