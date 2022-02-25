//
//  ExercisingModulePresenter.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class ExercisingModulePresenter: ExercisingModulePresenterProtocol {
    func showSuccessAlert() {
        view?.showSuccessAlert()
    }
    
    func showFailedAlert() {
        view?.showFailedAlert()
    }

    var view : ExercisingModuleViewProtocol?
    var router: ExercisingModuleRouterProtocol?
    var interactor: ExercisingModuleInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func createRecord(model: RecordModel) {
        interactor?.createRecord(model: model)
    }
    
}
