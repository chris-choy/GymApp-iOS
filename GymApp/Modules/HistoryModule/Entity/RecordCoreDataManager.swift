//
//  RecordCoreDataManager.swift
//  GymApp
//
//  Created by Chris on 2020/11/29.
//  Copyright © 2020 Chris. All rights reserved.
//

//import Foundation
import CoreData


class RecordCoreDataManager {
    
    let context = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    func fetchAllRecords() -> [Record]? {
        
        let request : NSFetchRequest<Record> = Record.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
            
        } catch  {
            print(error)
        }
    
        return nil
    }
    
    func createRecord(planName: String, recordSection: [RecordSection] ) -> Record? {
        // 需要结合Plan和RecordSection一起创建。
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
        
        object.planName = planName
        
        // Record needs to relate to the record section.
        object.recordSectionList = NSOrderedSet(object: recordSection)
        
        do {
            try context.save()
            return object
        } catch let err {
            print(err)
            return nil
        }
        
    }

    func deleteRecord(id: NSManagedObjectID){
        
        do {
            if let record = try context.existingObject(with: id) as? Record {
                
                if let sectionList = record.recordSectionList?.array as? [RecordSection] {
                    for section in sectionList {
                        // Delete sections.
                        if let rowList = section.recordRowList?.array as? [RecordRow] {
                            for row in rowList{
                                // Delete rows.
                                context.delete(row)
                            }
                        }
                        context.delete(section)
                    }
                }
                context.delete(record)
                try context.save()
            }
            
        } catch {
            print(error)
        }
    }
    
    func createRecord(model: RecordModel) -> Record? {
        
        let record = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
        
        
        record.id = Int32(model.id)
        record.planName = model.planName
        record.date = model.date
        record.totalTime = Int64(model.totalTime)
        
        // Creating the RecordSection.
        let sectionManager = RecordSectionCoreDataManager()
        
        for sectionModel in model.recordSectionList {
            if let section = sectionManager.create(recordSectionModel: sectionModel) {
                // Creating the RecordRow
                let rowManager = RecordRowCoreDataManager()
                for rowModel in sectionModel.recordRowList {
                    if let row = rowManager.create(recordRowModel: rowModel) {
                        row.rowSection = section
                        section.addToRecordRowList(row)
                    }
                }
                section.record = record
                record.addToRecordSectionList(section)
            }
            
        }
        
        do {
            try context.save()
            return record
        } catch let err {
            print(err)
            return nil
        }
        
    }
    
}

extension Record {
    func toRecordModel() -> RecordModel {

        let sectionList = self.recordSectionList?.array as! [RecordSection]
        
        let model = RecordModel(
            id: Int(self.id),
            planName: self.planName!,
            date: self.date!,
            totalTime: Int(self.totalTime),
            recordSectionList: sectionList.toRecordSectionModels())
        
        return model
    }
}

extension Array where Element == Record {
    func toRecordModels() -> [RecordModel] {
        
        var models:[RecordModel] = []
        
        for r in self {
            models.append(r.toRecordModel())
        }
        
        return models
        
    }
}
