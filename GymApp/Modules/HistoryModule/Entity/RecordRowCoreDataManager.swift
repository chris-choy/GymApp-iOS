//
//  RecordRowCoreDataManager.swift
//  GymApp
//
//  Created by Chris on 2020/11/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData



class RecordRowCoreDataManager {
    
    let context = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    func fetchAll() -> [RecordRow]? {
        let request : NSFetchRequest<RecordRow> = RecordRow.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
            
        } catch  {
            print(error)
        }
        
        return nil
    }
    
    func create(costTime: Int, times: Int, value: Float) -> RecordRow? {
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "RecordRow", into: context) as! RecordRow
        
        
        object.costTime = Int64(costTime)
        object.times = Int16(costTime)
        object.value = value
        
        do {
            try context.save()
            return object
        } catch let err {
            print(err)
            return nil
        }
        
    }
    
    func create(recordRowModel: RecordRowModel) -> RecordRow? {
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "RecordRow", into: context) as! RecordRow
        
        object.costTime = Int64(recordRowModel.costTime)
        object.times = Int16(recordRowModel.times)
        object.value = recordRowModel.value
        
        do {
            try context.save()
            return object
        } catch let err {
            print(err)
            return nil
        }
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }

}

extension RecordRow {
    func toRecordRowModel() -> RecordRowModel {
        
        return RecordRowModel(costTime: Int(self.costTime), times: Int(self.times), value: self.value)
        
    }
}

extension Array where Element == RecordRow {
    func toRecordRowModels() -> [RecordRowModel] {
        
        var models:[RecordRowModel] = []
        
        for r in self {
            models.append(r.toRecordRowModel())
        }
        
        return models
        
    }
}
