//
//  SportModuleInteractor.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation

class SportModuleInteractor: SportModuleInteractorProtocol {
    
    let manager = SportDataManager()
    
    func fetchAllSports() -> [Sport]? {
        if let result = manager.fetchAllSport() {
            return result
        } else {
            return nil
        }
        
    }
    
    func fetchAllSportFromDB(){
        
        SportService.shared.getAllSports { res in
            switch(res){
            case .success(_):
                print("a")
            case.failure(let err):
                print(err)
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
    
    
    
    
}
