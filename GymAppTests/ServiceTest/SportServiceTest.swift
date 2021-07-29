//
//  SportServiceTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/7/27.
//  Copyright © 2021 Chris. All rights reserved.
//


import XCTest

@testable import GymApp
class SportServiceTest: XCTestCase {

    func testGetAllSport(){
        
        
        print("------------------------------testGetAllSport------------------------------")
        
        let exp = expectation(description: "")
        
        // 登陆,获取jwt.
//        UserService.shared.signIn(username: "user1", password: "password1"){
//            res in
//            switch(res){
//            case .success(let jwt):
//                UserDefaults.standard.setValue(jwt.id_token, forKey: "id_token")
//                UserDefaults.standard.synchronize()
//
//
//                print("success:\(jwt.id_token)")
//
//                exp.fulfill()
//
//            case .failure(let err):
//                print("failure:!!!!!")
//                print(err)
//                exp.fulfill()
//            }
//        }
        
        
        
        // 进行操作.
        SportService.shared.getAllSports { res in
            switch(res){
            case .success(_):
                print("success")
                exp.fulfill()
            case .failure(_):
                exp.fulfill()
                print("fail")
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
        
        print("------------------------------testGetAllSport------------------------------")
    }
    
}
