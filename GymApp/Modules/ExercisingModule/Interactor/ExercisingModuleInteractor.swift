//
//  ExercisingModuleInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class ExercisingModuleInteractor: ExercisingModuleInteractorProtocol {
    func createRecord(model: RecordModel) -> Bool {
        let recordManager = RecordCoreDataManager()
        
//        if let result = recordManager.createRecord(model: model){
////            print(result)
//            return true
//        }
        
        return false
    }
}
