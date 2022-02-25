//
//  PlanTest.swift
//  GymAppTests
//
//  Created by Chris on 2020/10/7.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
import CoreData
@testable import GymApp

class PlanTest: XCTestCase {
    
    
    /*
     /Users/chris/Library/Developer/CoreSimulator/Devices/6B835C68-F667-45EE-A3C3-333E72CB44D7/data/Containers/Data/Application/153E956A-4AF2-4498-805C-EBF756C7C987/
     */
    func testCoredataPath(){
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }
    
    
    
    func testClearAllData(){
        
        let fetchPlanRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Plan")
        let deletePlanRequest = NSBatchDeleteRequest(fetchRequest: fetchPlanRequest)
        
        let planSectionRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlanSection")
        let deleteSectionRequest = NSBatchDeleteRequest(fetchRequest: planSectionRequest)
        
        let planRowRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PlanRow")
        let deleteRowRequest = NSBatchDeleteRequest(fetchRequest: planRowRequest)

        do {
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deletePlanRequest)
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deleteSectionRequest)
            try CoreDataManagedContext.sharedInstance.managedObjectContext.execute(deleteRowRequest)

//            try myPersistentStoreCoordinator.execute(deleteRequest, with: CoreDataManagedContext.sharedInstance.managedObjectContext)
        } catch let error as NSError {
            // TODO: handle the error
        }
        
    }
    
    func testFetchAllPlans(){
        let manager = PlanCoreDataManager()
        
        let result = manager.fetchAllPlans()
        XCTAssertNotNil(result)

        print("count = \(result!.count)")

        for item in result! {
            print("------------------------------------------------")
            print("name = \(item.name!)")
            
//            if let sectionList = item.planSections?.allObjects as? [PlanSection] {
//                for section in sectionList{
//                    if let rowList = section.planRows?.allObjects as? [PlanRow]{
//                        print(rowList.toPlanRowModels())
//                    }
//                }
//            }
            
//            print(item.toPlanModel())
            
            print("------------------------------------------------")
            
            
//            let plan = item.toPlanModel()
//            print(plan)
        }
    }
    
    func testDelePlan(){
        let manager = PlanCoreDataManager()
        
        if let planList = manager.fetchAllPlans(){
            
            
            // Save the objectId and test after delete operation.
            var idList:[NSManagedObjectID] = []
            
            if let plan = planList.first {
                if let sectionList = plan.planSections?.allObjects as? [PlanSection]{
                    for section in sectionList {
                        
                        if let rowList = section.planRows?.allObjects as? [PlanRow] {
                            for row in rowList {
                                idList.append(row.objectID)
                            }
                        }
                        idList.append(section.objectID)
                    }
                }
                idList.append(plan.objectID)
                
                // Excute the delete operation.
                manager.deletePlan(id: plan.objectID)
                
                let context = CoreDataManagedContext.sharedInstance.managedObjectContext
                do {
                    for id in idList{
                        
                        let result = try context.existingObject(with: id)
                        
                        XCTAssertNil(result)
                    }
                } catch {
                    print(error)
                }
                
                
                
                
                
            }
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    func testDeleteAllPlans(){
        
        let manager = PlanCoreDataManager()
        manager.deleteAllPlans()
        
    }
    
    
    func testPlanFetchById(){
        let manager = PlanCoreDataManager()
        let result = manager.fetchPlan(name: "Plan Test 1")
        
        let result2 = manager.fetchPlan(objectId: result!.objectID)
        
        XCTAssertEqual(result?.name, result2?.name)
    }
    
    func testCreatePlanWithJson(){
        
        print("--------------------testCreatePlanWithJson--------------------")
        
        let str = """
            [{"id":217,"name":"Plan1","seq":1,"user_id":4,"sectionList":[{"id":218,"seq":1,"plan_id":217,"sport":{"name":"A1","unit":"A","id":29,"user_id":4,"last_changed":1629217589000},"rowList":[{"id":219,"plan_id":217,"plan_section_id":218,"seq":1,"value":11.0,"times":2,"restTime":60,"lastValue":0,"last_changed":1637660016000}],"last_changed":1637660015000},{"id":220,"seq":2,"plan_id":217,"sport":{"name":"B1","unit":"B","id":30,"user_id":4,"last_changed":1629217954000},"rowList":[{"id":221,"plan_id":217,"plan_section_id":220,"seq":1,"value":22.0,"times":4,"restTime":5,"lastValue":0,"last_changed":1637660016000}],"last_changed":1637660016000},{"id":222,"seq":3,"plan_id":217,"sport":{"name":"Test133","unit":"Test13","id":32,"user_id":4,"last_changed":1629278997000},"rowList":[{"id":223,"plan_id":217,"plan_section_id":222,"seq":1,"value":11.0,"times":5,"restTime":5,"lastValue":0,"last_changed":1637743080000}],"last_changed":1637743080000}],"last_changed":1637660015000},{"id":224,"name":"测试计划","seq":2,"user_id":4,"sectionList":[{"id":225,"seq":1,"plan_id":224,"sport":{"name":"哑铃弯举","unit":"kg","id":35,"user_id":4,"last_changed":1634109643000},"rowList":[{"id":226,"plan_id":224,"plan_section_id":225,"seq":1,"value":55.0,"times":7,"restTime":248,"lastValue":0,"last_changed":1637743226000}],"last_changed":1637743139000},{"id":228,"seq":2,"plan_id":224,"sport":{"name":"仰卧起坐","unit":"个","id":33,"user_id":4,"last_changed":1634109596000},"rowList":[{"id":229,"plan_id":224,"plan_section_id":228,"seq":1,"value":66.0,"times":3,"restTime":5,"lastValue":0,"last_changed":1637743139000},{"id":232,"plan_id":224,"plan_section_id":228,"seq":2,"value":7.0,"times":7,"restTime":6,"lastValue":0,"last_changed":1637743216000},{"id":233,"plan_id":224,"plan_section_id":228,"seq":3,"value":11.0,"times":29,"restTime":300,"lastValue":0,"last_changed":1637743216000}],"last_changed":1637743139000},{"id":230,"seq":3,"plan_id":224,"sport":{"name":"飞鸟","unit":"kg","id":34,"user_id":4,"last_changed":1634109611000},"rowList":[{"id":231,"plan_id":224,"plan_section_id":230,"seq":1,"value":88.0,"times":8,"restTime":1026,"lastValue":0,"last_changed":1637743139000}],"last_changed":1637743139000}],"last_changed":1637743139000}]
            """
            
        if let data = str.data(using: .utf8){
            
            do {
                let plans = try JSONDecoder().decode([PlanModel].self, from: data)
                
                for p in plans {
                    if let planResult = PlanCoreDataManager().createPlan(model: p){
                        print(planResult.toPlanModel())
                    }
                    
                }
                    
                    
            } catch {
                print(error)
            }
            
            
            
        }
        
            
        print("--------------------testCreatePlanWithJson end--------------------")
        
        
    }
    
    
    /*
    
    func testCreateNewPlanWithoutSectionList(){
        
        
        let planManager = PlanCoreDataManager()
        let sectionManager = PlanSectionCoreDataManager()
        
        // 创建新Plan
        let name = "Plan Test 1"
        
        if let newPlan = planManager.createPlan(name: name, sectionList: nil) {
            XCTAssertEqual(newPlan.name, name)
        
        }
        
        // 验证：是否可以避免重复创建相同名称的Plan。
        // “Plan Test” 已经存在。
//        let planModel = PlanModel(name: "Plan Test", sectionList: nil)
//        XCTAssertNil(planManager.createPlan(planModel: planModel))
        
    }
    
    func testCreatePlanWithPlanModel(){
        let planManager = PlanCoreDataManager()
        let name = "Plan Test 2"
        let model = PlanModel(id: 0,objectId: nil, name: name, sectionList: [], last_changed: 0)
        
        let createResult = planManager.createPlan(plan: model)
        
        if let fetchResult = planManager.fetchPlan(name: name){
            XCTAssertEqual(createResult?.name, fetchResult.name)
        }
    }
    
    
    
    func testCreatePlanWithPlanModelAndRow(){
        var planModel : PlanModel = {
            let row1 = PlanRowModel(id: 0,
                                    seq: 1,
                                    lastValue: 0,
                                    value: 15,
                                    times: 8)
            let row2 = PlanRowModel(id: 0,
                                    seq: 2,
                                    lastValue: 0,
                                    value: 16,
                                    times: 8)
            let row3 = PlanRowModel(id: 0,
                                    seq: 3,
                                    lastValue: 0,
                                    value: 15,
                                    times: 8)
            let row4 = PlanRowModel(id: 0,
                                    seq: 4,
                                    lastValue: 0,
                                    value: 16,
                                    times: 8)
            let section1 = PlanSectionModel(id: 0,
                                            sectionIndex: 0,
                                            unit: "kg",
                                            rowList: [row1,row2,row3,row4],
                                            sport: SportModel(id: 0, objectId: nil,name: "Sport1",
                                                              unit: SportUnitModel(name: "tag1", sportNames: nil)))
            
            let row5 = PlanRowModel(id: 0,
                                    seq: 1,
                                    lastValue: 0,
                                    value: 5,
                                    times: 8)
            
            let row6 = PlanRowModel(id: 0,
                                    seq: 2,
                                    lastValue: 0,
                                    value: 5,
                                    times: 10)
            
            let section2 = PlanSectionModel(id: 0,
                                            sectionIndex: 1,
                                            unit: "unit1",
                                            rowList: [row5,row6],
                                            sport: SportModel(id: 0, objectId: nil,name: "Sport2",
                                                              unit: SportUnitModel(name: "unit1", sportNames: nil)))
            
//            let row7 = PlanRowModel(setNum: 1,
//                                    lastValue: 0,
//                                    value: 8,
//                                    times: 8)
//
//            let row8 = PlanRowModel(setNum: 2,
//                                    lastValue: 0,
//                                    value: 8,
//                                    times: 10)
//
//            let row9 = PlanRowModel(setNum: 3,
//                                    lastValue: 0,
//                                    value: 8,
//                                    times: 10)
            
            
            
            let sectionList = [section1, section2]
            
            
            let model = PlanModel(
                id: nil,
                objectId: nil,
                name: "Plan Test 3",
                sectionList:sectionList,
                last_changed: 0)
            
            return model
        }()
        
//        let rowManager = PlanRowCoreDataManager()
//        let sectionManager = PlanSectionCoreDataManager()
        let planManager = PlanCoreDataManager()
        
        
        // Create the row object.
//        for section in planModel.sectionList {
//
//            var sectionObject = sectionManager.createPlanSection(model: section)
//
//        }
        
        
        // Create the section object.
        
        // Create the plan object.
        if let result = planManager.createPlan(plan: planModel) {
            print(result)
            
            print("\n")
            
            print(result.toPlanModel())
        }
        
    }
    
    func testPlanFetchByName(){
        let planManager = PlanCoreDataManager()
        
        if let p = planManager.fetchPlan(name: "Plan Test 1") {
            print("Success! name = \(p.name!)")
//            if let section = p.planSections {
//                print("asdf")
//            }
        }
        
    }
    
    
    func testUpdatePlan(){
        
        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))

        // 思路：
        // 1.先取回object转化成model
        // 2.将修改之后的model存储到object
        
        
        let planManager = PlanCoreDataManager()
        let sportManager = SportDataManager()
        
        // Fetch Result.
        let result = planManager.fetchPlan(name: "Plan Test 1")
        var planModel = result?.toPlanModel()
        
        // 操作前结果输出
        print("Begin !!!!!!!!!!!!")
//        print("Do Before!")
        print(planModel!)
        print("\n Before \n")
        
        // 开始操作
        // 取回sport1,创建row1和row2，构建section1
        
        let row1 = PlanRowModel(id: 0,
                                seq: 1, lastValue: 11, value: 11, times: 11)
        let row2 = PlanRowModel(id: 0,
                                seq: 2, lastValue: 22, value: 22, times: 22)
        
        
        let section1 = PlanSectionModel(
            id: 0,
            sectionIndex: 0,
            unit: "kg",
            rowList: [row1,row2],
            sport: (sportManager.fetchSport(name: "Sport 1")?.toSportModel())!)
        
        planModel?.sectionList.append(section1)
        
        
        
        
        // 操作结束 ，输出操作后的planModel
//        print(planModel!)
        
        
        // 进行update操作
        planManager.updatePlan(plan: planModel!)
        
        // 取回结果看看
        let result2 = planManager.fetchPlan(name: "Plan Test 1")
        print("\nResult:")
        print(result2!.toPlanModel())
        
    }
    
    
    */
    
}
