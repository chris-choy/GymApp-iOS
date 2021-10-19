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
        if let result = manager.fetchAllSport() {
            return result
        } else {
            return nil
        }
        
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
        
        
        // 1. Fetch from DB.
//        SportService.shared.getAllSports { res in
//            switch(res){
//            case .success(let data):
//                do {
//                    let sports = try JSONDecoder().decode([SportModel].self, from: data)
//
//                    // 2. Check if they need to be updated.
//                    let manager = SportDataManager()
//                    for sport in sports {
//                        if let sportInCD = manager.fetchSport(name: sport.name) {
//                            if sportInCD.toSportModel().last_changed != sport.last_changed {
//
//                                // Need to be updated.
//                                manager.updateSport(objectId: sportInCD.objectID, requestModel: sport)
//
//                            }
//                        } else {
//                            // Not exists, create it.
//                             _ = manager.createSport(model: sport)
//                        }
//
//
//                    }
//
//                } catch {
//                    print(error)
//                }
//
//            case .failure(let err):
//                print(err)
//            }
//        }

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
