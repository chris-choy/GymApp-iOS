//
//  ExercisingModuleInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class ExercisingModuleInteractor: ExercisingModuleInteractorProtocol {
    var presenter: ExercisingModulePresenterProtocol?
    
    func createRecord(model: RecordModel) {
        
        do {
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            
            let data = try encoder.encode(model)
            
            RecordService.shared.createRecord(recordData: data) { res in
                switch(res){
                case .success(()):
                    DispatchQueue.main.async {
                        self.presenter?.showSuccessAlert()
                    }
                case .failure(let err):
                    DispatchQueue.main.async {
                        self.presenter?.showFailedAlert()
                    }
                    
                    print(err)
                }
            }
        } catch {
            print(error)
        }

    }

}
