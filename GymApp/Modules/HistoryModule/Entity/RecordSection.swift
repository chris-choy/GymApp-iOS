//
//  RecordSection.swift
//  GymApp
//
//  Created by Chris on 2020/11/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData


class RecordSectionCoreDataManager {
    
    let context = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    func fetchAll() -> [RecordSection]? {
        
        let request : NSFetchRequest<RecordSection> = RecordSection.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
            
        } catch  {
            print(error)
        }
        
        return nil
        
    }
    
    func create(sportName:String, record: Record) -> RecordSection? {
        let object = NSEntityDescription.insertNewObject(forEntityName: "RecordSection", into: context) as! RecordSection

        let sportManager = SportDataManager()
        if let sport = sportManager.fetchSport(name: sportName) {
            // Sport does exist.
            
            // Set values.
            object.sport = sport
            object.costTime = 0
            object.date = Date.init()
//            object.recordRowList = NSOrderedSet(object: rowList)
//            object.recordRowList = NSOrderedSet(array: rowList)
            object.record = record
            
            do {
                try context.save()
                return object
            } catch let err {
                print(err)
                return nil
            }
        }
        
        return nil
    }
    
    func create(recordSectionModel: RecordSectionModel) -> RecordSection? {
        let object = NSEntityDescription.insertNewObject(forEntityName: "RecordSection", into: context) as! RecordSection

        let sportManager = SportDataManager()
        if let sport = sportManager.fetchSport(name: recordSectionModel.sportName) {
            // Sport does exist.
            
            // Set values.
            object.sport = sport
            object.costTime = 0
            object.date = Date.init()
            
//            object.recordRowList = NSOrderedSet(object: rowList)
//            object.recordRowList = NSOrderedSet(array: rowList)
            
//            object.record = record
            
            do {
                try context.save()
                return object
            } catch let err {
                print(err)
                return nil
            }
        }
        
        return nil
    }
    
    func addRow() {
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }

}

extension RecordSection {
    func toRecordSectionModel() -> RecordSectionModel {
        let sport = self.sport!.toSportModel()
        
        let rowList = self.recordRowList?.array as! [RecordRow]
        
        
        return RecordSectionModel(sportName: sport.name, sportUnit: sport.unit, recordRowList: rowList.toRecordRowModels())
        
    }
}

extension Array where Element == RecordSection {
    func toRecordSectionModels() -> [RecordSectionModel] {
        
        var models:[RecordSectionModel] = []
        
        for r in self {
            models.append(r.toRecordSectionModel())
        }
        
        return models
        
    }
}
