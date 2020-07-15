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
    
    
}
