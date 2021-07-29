//
//  HistoryModulePresenter.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class HistoryModulePresenter: HistoryModulePresenterProtocol {
    
    var view : HistoryModuleViewProtocol?
    var router: HistoryModuleRouterProtocol?
    var interactor: HistoryModuleInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func loadRecordData() -> [RecordModel]{
        return interactor!.loadRecordData()
    }
    
}
