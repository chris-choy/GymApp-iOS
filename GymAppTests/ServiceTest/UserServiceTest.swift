//
//  UserServiceTest.swift
//  GymAppTests
//
//  Created by Chris on 2021/12/27.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit
import XCTest

@testable import GymApp
class UserServiceTest: XCTestCase {
    
    
    
    public func testSignUp(){
        
        
        
    }
    
    
    public func testGetProfile(){
        
        let exp = expectation(description: "")
        
        
        // Get the user profile.
        UserService.shared.getProfile(){ res in
            switch res{
            case .failure(let err):
                print("error")
                print(err)
                
                exp.fulfill()
                
            case .success(let user):
                print("success")
                print(user)
                exp.fulfill()
                // Send the user profile to presenter and show.
                
                
            }
        }
        
        
        waitForExpectations(timeout: 10, handler: nil)
        
        
    }
    
}
