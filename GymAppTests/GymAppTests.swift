//
//  GymAppTests.swift
//  GymAppTests
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import XCTest
@testable import GymApp


//        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))


class GymAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        testCreatePlanExample()
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreatePlanExample(){
        
        
        let planManager = PlanCoreDataManager()
        
        // 创建新Plan
        let name = "Plan Test 1"
//        let newPlanModel = PlanModel(name: name, sectionList: nil)
        if let newPlan = planManager.createPlan(name: name, sectionList: nil) {
            XCTAssertEqual(newPlan.name, name)
        
        }
        
        // 验证：是否可以避免重复创建相同名称的Plan。
        // “Plan Test” 已经存在。
//        let planModel = PlanModel(name: "Plan Test", sectionList: nil)
//        XCTAssertNil(planManager.createPlan(planModel: planModel))
        
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
    
    func testSportModuel(){
        
//        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))

        
        let manager = SportDataManager()
        
        
        
        
//        manager.fetchAllSport()
//         创建运动 name="SportTest" unit="kg"
//        var s = manager.createSport(name: "Sport 1", unit: "kg")
//        s = manager.createSport(name: "Sport 2", unit: "kg")
//        s = manager.createSport(name: "Sport 3", unit: "kg")
        
        
        
//        XCTAssertNotNil(s)
//        XCTAssertEqual(s?.name, "SportTest 3")
        
        
        
        
//        let result = manager.fetchSport(name: "SportTest")
//        XCTAssertNotNil(result)
//        XCTAssertEqual(result?.name, "SportTest")
        
        
        
        
        
        let result = manager.fetchAllSport()
        XCTAssertNotNil(result)

        print("count = \(result!.count)")

        for item in result! {
            print("\(item.name!) unit=\(item.unit?.name!)")
        }
//        XCTAssertEqual(result?.count, 0)
        
        
        // 删除测试
//        manager.deleteSport(name: "Sport 1")
//        manager.deleteSport(name: "Sport 2")
//        manager.deleteSport(name: "Sport 3")
//        let result = manager.fetchAllSport()
//        XCTAssertEqual(result?.count, 0)
        
    }
    
    func testFetchAllPlans(){
        let manager = PlanCoreDataManager()
        
        let result = manager.fetchAllPlans()
        XCTAssertNotNil(result)

        print("count = \(result!.count)")

        for item in result! {
            print("name = \(item.name!)")
        }
    }
    
    func testPlanFetchById(){
        let manager = PlanCoreDataManager()
        let result = manager.fetchPlan(name: "Plan Test 1")
        
        let result2 = manager.fetchPlan(id: result!.objectID)
        
        XCTAssertEqual(result?.name, result2?.name)
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
        let row1 = PlanRowModel(lastValue: 11, value: 11, times: 11)
        let row2 = PlanRowModel(lastValue: 22, value: 22, times: 22)
        let section1 = PlanSectionModel(
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
    
    
    
    
    func testUnitDataManager(){
        
        let manager = SportUnitDataManager()
        
        // 测试创建重复
        if let u = manager.createUnit(name: "kg") {
            print (u.name!)
        }
        else {
            print("failed")
        }
        
        // 测试按name取回
        // unit test 存在
        // unit test11 返回nil
//        if let u = manager.fetchUnit(name: "unit test"){
//            XCTAssertEqual(u.name, "unit test")
//        }
//
//        let u = manager.fetchUnit(name: "unit test11")
//        XCTAssertNil(u)
        
        
        // 测试取回全部
        // 先创建unit test9，在取回全部看看是否有两个存在，一个unit test 和一个 unit test9
//            let u = manager.createUnit(name: "unit test9")
//            XCTAssertNotNil(u)
//            XCTAssertEqual(u?.name, "unit test9")
//
//            let result = manager.fetchAllUnit()
//            XCTAssertNotNil(result)
////            XCTAssertEqual(result?.count, 2)
//            if let r = result {
////                XCTAssertEqual(r[0].name, "unit test")
////                XCTAssertEqual(r[1].name, "unit test9")
//                for i in r {
//                    print(i.name)
//                }
//            }
        
    }

}
