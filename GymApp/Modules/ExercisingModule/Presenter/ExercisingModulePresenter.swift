//
//  ExercisingModulePresenter.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class ExercisingModulePresenter: ExercisingModulePresenterProtocol {
    
    var view : ExercisingModuleViewProtocol?
    var router: ExercisingModuleRouterProtocol?
    var interactor: ExercisingModuleInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func createRecord(model: RecordModel) -> Bool {
        if (interactor!.createRecord(model: model) == true){
            return true
        } else {
            return false
        }
        
    }
    
}
