//
//  UnitEntity.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

enum DataType {
    case tag
    case unit
}

struct SportUnitModel: Codable {
    let name: String

    // var sports: [SportModel]?
    // It can only store the name of the sport.
    var sportNames: [String]?
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        try container.encode(name)
    
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        name = try container.decode(String.self)
        sportNames = nil
    }
    
    init(name: String, sportNames: [String]?) {
        self.name = name
        self.sportNames = sportNames
    }
    
}

extension SportUnit{
    func toSportUnitModel() -> SportUnitModel{
        
        if self.sport?.count != 0 {
            let sports = self.sport?.allObjects as! [Sport]
            
            var sportNames : [String] = []
            for s in sports {
                sportNames.append(s.name!)
            }
            return SportUnitModel(name: self.name!, sportNames: sportNames)
        }
        else {
            return SportUnitModel(name: self.name!, sportNames: nil)
        }


//        let sportArray = self.sport?.allObjects as! [Sport]
//
//        let model = SportUnitModel(name: self.name!,
//                                   sports: sportArray.toSportModels())
//        return model
//
    }
}


class SportUnitDataManager {
    var fc: NSFetchedResultsController<SportUnit>?
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
    
    func fetchAllUnit() -> [SportUnit]?{

        let request : NSFetchRequest<SportUnit> = NSFetchRequest(entityName: "SportUnit")
        
        do {
            let result = try managedObjectContext.fetch(request)
            return result
        } catch {
            print("fetchAllUnit Error.")
        }
        
        return nil
    }
    
    
    
    func fetchUnit(name: String) -> SportUnit? {
//        setupContext()
        
        let context = CoreDataManagedContext.sharedInstance.managedObjectContext

        let request : NSFetchRequest<SportUnit> = SportUnit.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try context.fetch(request)
            
            if(result.count == 1){
                return result.first as SportUnit?
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
        if !isAlreadyExits(name: name) {
            let unit = NSEntityDescription.insertNewObject(forEntityName: "SportUnit", into: managedObjectContext) as! SportUnit
            
            unit.name = name
            
            try! managedObjectContext.save()
        
            return unit
        }
        return nil
    }
}

extension Array where Element == SportUnit {
    func toSportUnitModels() -> [SportUnitModel]{
        var set: [SportUnitModel] = []
        for u in self {
            set.append(u.toSportUnitModel())
        }
        
        // Sort by the setNum.
        // Because the CoreData saved the data not in order.
//        set.sort(by: {$0.setNum < $1.setNum})
        
        return set
    }
}
