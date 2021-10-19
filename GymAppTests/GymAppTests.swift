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
        
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
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
            print("\(item.name!) unit=\(item.unit)")
        }
//        XCTAssertEqual(result?.count, 0)
        
        
        // 删除测试
//        manager.deleteSport(name: "Sport 1")
//        manager.deleteSport(name: "Sport 2")
//        manager.deleteSport(name: "Sport 3")
//        let result = manager.fetchAllSport()
//        XCTAssertEqual(result?.count, 0)
        
    }
    
    struct NameAndIndex{
        var name: String
        var index: Int
    }
    
    struct HeaderStruct {
        var letter: Character
        var ni: [NameAndIndex]
    }
    
    func testPinYin(){
        let strList = ["仰!卧起坐","~引体向上","asd","asdk","abc","asj","fjir","ti","lee","gjib","yl","zdf","gutn","quer","tgk","kdl","utie"]
        
        var result : [String] = []
        
        
        
        
        for index in 0..<strList.count {
            // If the first letter of name is Latin Capital Letter or CJK Unified Ideographs.
            let reg = ""
            
            
            var r = ""
            
            for c in strList[index]{
                if(true){
//                if ("\u{4E00}" <= c && c <= "\u{9FA5}") {
                    // CJK Unified Ideographs
                    let s = NSMutableString(string: "\(c)")
                    CFStringTransform(s, nil, kCFStringTransformToLatin, false)
                    CFStringTransform(s, nil, kCFStringTransformStripDiacritics, false)
                    
                    if let char : Character = String(s).first {
                        r.append("\(char)")
                    }
                    
                } else if ("\u{0041}" <= c && c <= "\u{005A}") || ("\u{0061}" <= c && c <= "\u{007A}") {
                    // Latin Capital Letter
                    r.append(c)
                }
                
            }
            result.append(r)
        }
        
        print(result)
    }
    
    
    func testWhetherEngOrChi(){
        
        let strList = ["仰卧起坐","引体向上","*阿迪舒服","/sdf","!sd3a","12","asd","asdk","abc","asj","fjir","ti","lee","gjib","yl","zdf","gutn","quer","tgk","kdl","utie"]
        
        let pattern = "^[a-zA-Z\u{4e00}-\u{9fa5}]"
        
        for name in strList{
            if let _ = name.range(of: pattern,options: .regularExpression){
                print("\(name)")
            } else {
                print("\(name):        x")
            }
        }
        
        
    }
    
    
    func testStringSort(){
        
        let strList = ["asd","似懂非懂","耳机","asdk","abc","asj","fjir","ti","lee","gjib","yl","zdf","gutn","quer","tgk","kdl","utie"]
        
        var headerList : [HeaderStruct] = []
        
        for index in 0...strList.count-1{
            let fir = strList[index].first
            if let headerIndex = headerList.firstIndex(where: {$0.letter == strList[index].first}){
                headerList[headerIndex].ni.append(NameAndIndex(name: strList[index], index: index))
            } else {
                if let letter = strList[index].first{
                    headerList.append(HeaderStruct(letter: letter,
                                                   ni: [NameAndIndex(name: strList[index],
                                                                     index: index)]))
                }
            }
        }
        
        headerList.sort(by: {$0.letter < $1.letter})
        for i in 0..<headerList.count{
            headerList[i].ni.sort(by: {$0.name < $1.name})
        }
        
//        for var h in headerList {
//            h.ni.sort(by: {$0.name < $1.name})
////            print(h)
//        }
        
        
        
//        headerList.forEach { hea in
//            hea.ni.sort(by: {$0.name < $1.name})
//        }
        
        for h in headerList {
            print(h)
        }
        
        
        
        
        
    }
    
    
    
    
    
    

}
