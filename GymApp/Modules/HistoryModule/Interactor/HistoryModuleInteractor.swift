//
//  HistoryModuleInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class HistoryModuleInteractor: HistoryModuleInteractorProtocol {
    
    func showRecords() {
        let result = self.loadRecordData()
        self.presenter?.showRecords(records: result)
    }
    
    
    var presenter: HistoryModulePresenterProtocol?
    
    func loadRecordData() -> [RecordModel] {
        let manager = RecordCoreDataManager()
        
        if let result = manager.fetchAllRecords() {
            return result.toRecordModels()
        } else {
            return []
        }
        
    }
    
    func getAllRecords() {
        RecordService.shared.getAllRecords { res in
            switch(res) {
            case .success(_):
                DispatchQueue.main.async {
                    self.showRecords()
                }
            case .failure(let err):
                self.presenter?.showErrorAlert()
                print(err)
            }
        }
    }
}
