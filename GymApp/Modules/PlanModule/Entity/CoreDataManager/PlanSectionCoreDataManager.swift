//
//  PlanSectionCoreDataManager.swift
//  GymApp
//
//  Created by Chris on 2021/6/1.
//  Copyright © 2021 Chris. All rights reserved.
//

import CoreData

class PlanSectionCoreDataManager {
    var planSectionFC: NSFetchedResultsController<PlanSection>?
    let managedObjectContext = CoreDataManagedContext.sharedInstance.managedObjectContext
    let context = CoreDataManagedContext.sharedInstance.managedObjectContext

    // Fetch.
    func fetchPlanSections() {
        
        let request : NSFetchRequest<PlanSection> = PlanSection.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "seq", ascending: false)]
        
        planSectionFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            
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
        planSection.seq = model.seq
        planSection.id = Int32(model.id)
        planSection.plan_id = Int64(model.plan_id)
        planSection.last_changed = Int64(model.last_changed)
        
        // Relate to Sport.
        var sport = sportManager.fetchSport(name: model.sport.name)
        if sport != nil {
            planSection.sport = sport
        } else {
            print("Error: Sport(\(model.sport.name)) not found.")
            
            
            sport = sportManager.createSport(name: model.sport.name, unit: model.unit)
            
            guard sport != nil else {
                return nil
            }
            
            planSection.sport = sport
            
        }
        
        // Create the rows object and relate to them.
        for rowModel in model.rowList {
            
            if let row = rowManager.createPlanRow(row: rowModel) {
                planSection.addToPlanRows(row)
                
            } else {
                print("Error: RowCreate failed.")
                return nil
            }
        }

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
            id: Int(self.id),
            seq: Int16(self.seq),
            unit: self.sport!.unit!,
            rowList: rowArray.toPlanRowModels(),
            sport: self.sport!.toSportModel(),
            last_changed: Int(self.last_changed),
            plan_id: Int(self.plan_id))
            
        return model
    }
}

extension Array where Element == PlanSection {
    func toPlanSectionModels() -> [PlanSectionModel]{
        var set : [PlanSectionModel] = []
        for s in self {
            set.append(s.toPlanSectionModel())
        }
        
        set.sort(by: {$1.seq > $0.seq})
        return set
    }
    
}
