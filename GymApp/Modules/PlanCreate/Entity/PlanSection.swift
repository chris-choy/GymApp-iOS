//
//  PlanSection.swift
//  GymApp
//
//  Created by Chris on 2020/6/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData


struct PlanSectionModel {
    var sectionIndex: Int16
    let unit: String
    var rowList: [PlanRowModel] = []
    let sport: SportModel
}

extension Array where Element == PlanSection {
    func toPlanSectionModels() -> [PlanSectionModel]{
        var set : [PlanSectionModel] = []
        for s in self {
            set.append(s.toPlanSectionModel())
        }
        
        set.sort(by: {$1.sectionIndex > $0.sectionIndex})
        return set
    }
}

class PlanSectionCoreDataManager {
    var planSectionFC: NSFetchedResultsController<PlanSection>?
    let managedObjectContext = CoreDataManagedContext.sharedInstance.managedObjectContext
    let context = CoreDataManagedContext.sharedInstance.managedObjectContext
    
    
    // Fetch.
    func fetchPlanSections() {
        
        let request : NSFetchRequest<PlanSection> = PlanSection.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "setNum", ascending: false)]
        
        planSectionFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
//        do {
//            try planSectionFC?.performFetch()
//            if let object = planSectionFC?.fetchedObjects {
//                // Do something after readed.
//
//            }
//        } catch  {
//            print(error)
//        }
            
    }
    
    func createPlanSection(sport: Sport, rowList: NSSet?){
        
        let planSection = NSEntityDescription.insertNewObject(forEntityName: "PlanSection", into: managedObjectContext) as! PlanSection
        
        // Do something with planSection object.
        planSection.sport = sport
        
        if(rowList != nil){
            planSection.planRows = rowList
        } else {
            planSection.planRows = nil
        }
        
        try! managedObjectContext.save()
    }
    
    func createPlanSection(model: PlanSectionModel) -> PlanSection?{

        let sportManager = SportDataManager()
        let rowManager = PlanRowCoreDataManager()
        
        let planSection = NSEntityDescription.insertNewObject(forEntityName: "PlanSection", into: context) as! PlanSection
        
        
        // Do something with planSection object.
        
        // Set the index to sort.
        planSection.sectionIndex = model.sectionIndex
        
        // Relate to Sport.
        let sport = sportManager.fetchSport(name: model.sport.name)
        if sport != nil {
            planSection.sport = sport
        } else {
            print("Error: Sport(\(model.sport.name) not found.")
            return nil
        }
        
        // Create the rows object and relate to them.
        for rowModel in model.rowList {
            
//            // test
//            print(rowModel.value)
//            // testend
            
            if let row = rowManager.createPlanRow(row: rowModel) {
                planSection.addToPlanRows(row)
            } else {
                print("Error: RowCreate failed.")
                return nil
            }
        }
        
        // For test.
//        if let rows = planSection.planRows {
//            for item in rows {
//                print(item)
//            }
//        }
        
        // Fort test end.
        
        
        do {
            try context.save()
        } catch (let err){
            print(err)
        }
        
        
        return planSection
    }
    
}

extension PlanSection {
    func delete(){
        let context = CoreDataManagedContext.sharedInstance.managedObjectContext
        
        // Clear rows.
        if var rows = (self.planRows as? Set<PlanRow>){
            for row in rows {
                row.delete()
                rows.removeFirst()
            }
        }
        
        if(planRows?.count == 0){
            context.delete(self)
        } else {
            print("Error: planRows is not empty.")
        }
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    func toPlanSectionModel() -> PlanSectionModel{
        let rowArray = self.planRows?.allObjects as! [PlanRow]
        
        let model = PlanSectionModel(
            sectionIndex: Int16(self.sectionIndex),
            unit: self.sport!.unit!.name!,
            rowList: rowArray.toPlanRowModels(),
            sport: self.sport!.toSportModel())
        
        return model
    }
}

