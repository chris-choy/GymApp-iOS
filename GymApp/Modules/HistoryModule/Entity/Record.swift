//
//  Record.swift
//  GymApp
//
//  Created by Chris on 2020/11/29.
//  Copyright © 2020 Chris. All rights reserved.
//

//import Foundation
import CoreData


class RecordCoreDataManager {
    
    let context = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    func fetchAllRecords() -> [Record] {
        
        let request : NSFetchRequest<Record> = Record.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
            
        } catch  {
            print(error)
        }
        
//        return nil
//        return [Record]
    
        
        return []
    }
    
    func createRecord(planName: String, recordSection: [RecordSection] ) -> Record? {
        // 需要结合Plan和RecordSection一起创建。
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
        
        // Record needs to relate to the plan.
        let planManager = PlanCoreDataManager()
        
        if let plan = planManager.fetchPlan(name: planName) {
            object.plan = plan
        }
        
        // Record needs to relate to the record section.
        object.recordSectionList = NSOrderedSet(object: recordSection)
        
        
        do {
            try context.save()
            return object
        } catch let err {
            print(err)
            return nil
        }
        

        
//        return nil
    }
    
    func createRecordWithoutSection(planName: String) -> Record? {
        // 需要结合Plan和RecordSection一起创建。
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
        
        // Record needs to relate to the plan.
        let planManager = PlanCoreDataManager()
        
        if let plan = planManager.fetchPlan(name: planName) {
            object.plan = plan
            
            do {
                try context.save()
                return object
            } catch let err {
                print(err)
                return nil
            }
            
        } else {
            return nil
        }
        
        
        // Record needs to relate to the record section.
//        object.recordSectionList = NSOrderedSet(object: recordSection)
        
        
    }
    
    
    
    func createRecord(model: RecordModel) -> Record? {
        
        let record = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context) as! Record
        
        // Linking to the plan.
        let planManager = PlanCoreDataManager()
        if let planResult = planManager.fetchPlan(name: model.planName) {
            record.plan = planResult
        }
        
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
        let plan = self.plan!.toPlanModel()
        
        let sectionList = self.recordSectionList?.array as! [RecordSection]
        
        var model = RecordModel(planName: plan.name, date: self.date!, totalTime: Int(self.totalTime), recordSectionList: sectionList.toRecordSectionModels())
        
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


