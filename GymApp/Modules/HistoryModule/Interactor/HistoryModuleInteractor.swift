//
//  HistoryModuleInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class HistoryModuleInteractor: HistoryModuleInteractorProtocol {
    
    
    func loadRecordData() -> [RecordModel] {
        let manager = RecordCoreDataManager()
        
//        let result = manager.fetchAllRecords()
        
        return manager.fetchAllRecords().toRecordModels()
    }
}
