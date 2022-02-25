//
//  SportModuleInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class SportModuleInteractor: SportModuleInteractorProtocol {
    
    var presenter: SportModulePresenterProtocol?
    
    let manager = SportDataManager()
    
    func fetchAllSports() -> [Sport]? {
        return manager.fetchAllSport()
    }

    func fetchAllSportFromServer(){
        
        SportService.shared.getAllSports { res in
            switch(res){
            case .success(_):
                DispatchQueue.main.async {
                    self.presenter?.loadSportManagerViewData()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    self.presenter?.loadSportFail()
                    print(err)
                }
            }
        }

    }
    
    func saveSport(sport: SportModel, mode: SaveMode){
        do {
            let sportData = try JSONEncoder().encode(sport)
            
            SportService.shared.createSport(sport: sportData, mode: mode) { res in
                switch(res){
                case .success(_):
                    DispatchQueue.main.async {
                        self.presenter?.showCreateSuccess()
                    }
                    
                case .failure(let err):
                    
                    DispatchQueue.main.async {
                        self.presenter?.showFailMessage(message: "操作失败。")
                    }
                    
                    print(err)
                }
            }
        } catch {
            self.presenter?.showFailMessage(message: "操作失败。")
            print(error)
        }
        
    }
    
}
