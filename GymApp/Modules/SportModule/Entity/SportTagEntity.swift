//
//  SportTagEntity.swift
//  GymApp
//
//  Created by Chris on 2020/9/26.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

struct SportTagModel {
    let name: String
}

extension SportTag{
    func toSportTagModel() -> SportTagModel{
        let model = SportTagModel(name: self.name!)
        return model
    }
}

class SportTagDataManager {
    var fc: NSFetchedResultsController<SportTag>?
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
    
    func fetchAllTag() -> [SportTag]?{
        setupContext()

        let request : NSFetchRequest<SportTag> = NSFetchRequest(entityName: "SportTag")
        
        do {
            let result = try managedObjectContext?.fetch(request)
            return result
        } catch {
            print("fetchAllTag Error.")
        }
        
        return nil
    }
    
    
    
    func fetchTag(name: String) -> SportTag? {
//        setupContext()
        
        let context = CoreDataManagedContext.sharedInstance.managedObjectContext

        let request : NSFetchRequest<SportTag> = SportTag.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let result = try context.fetch(request)
            
            if(result.count == 1){
                return result.first as SportTag?
            }
            else {
                return nil
            }
            
        } catch {
            print("Failed.")
        }
        
        
        return nil
    }
    
    func isAlreadyExits(name: String) -> Bool{
        
        if (fetchTag(name: name) != nil){
            print("Error: \"\(name)\" already exists.")
            return true
        }
        
        return false
    }
    
    
    func createTag(name: String) -> SportTag?{
        setupContext()
        if !isAlreadyExits(name: name) {
            let tag = NSEntityDescription.insertNewObject(forEntityName: "SportTag", into: managedObjectContext!) as! SportTag
            
            tag.name = name
            try! managedObjectContext!.save()
            return tag
            
        }
        return nil
    }
}

extension Array where Element == SportTag {
    func toSportTagModels() -> [SportTagModel]{
        var set: [SportTagModel] = []
        for u in self {
            set.append(u.toSportTagModel())
        }
        
        // Sort by the setNum.
        // Because the CoreData saved the data not in order.
//        set.sort(by: {$0.setNum < $1.setNum})
        
        return set
    }
}
