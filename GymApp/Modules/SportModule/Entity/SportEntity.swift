//
//  SportModuleEntity.swift
//  GymApp
//
//  Created by Chris on 2020/7/5.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData


struct SportModel : Codable{
    var id: Int
    var objectId: NSManagedObjectID?
    
    var name: String
    var unit: String
    
    var user_id: Int
    var last_changed: Int
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case unit = "unit"
        case user_id = "user_id"
        case last_changed = "last_changed"
    }
    
    func encode(to encoder: Encoder) throws {
//        enum CodingKeys: String, CodingKey{
//            case id = "id"
//            case name = "name"
//            case unit = "unit"
//        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(unit, forKey: .unit)
        try container.encode(user_id, forKey: .user_id)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        objectId = nil
        name = try container.decode(String.self, forKey: .name)
        unit = try container.decode(String.self, forKey: .unit)
        user_id = try container.decode(Int.self, forKey: .user_id)
        last_changed = try container.decode(Int.self, forKey: .last_changed)
    }
    
    init(id: Int,
         objectId: NSManagedObjectID?,
         name: String,
         unit: String,
         user_id:Int,
         last_changed: Int) {
        self.id = id
        self.objectId = objectId
        self.name = name
        self.unit = unit
        self.user_id = user_id
        self.last_changed = last_changed
    }
    
}

struct SportResponseModel : Codable {
    var id : Int
    var name: String
    var unit: String
//    var user_id: Int
}


extension Sport{
    func toSportModel() -> SportModel{
        let model = SportModel(
            id: Int(id),
            objectId: objectID,
            name: self.name!,
            unit: self.unit!,
            user_id: Int(self.user_id),
            last_changed: Int(self.last_changed)
        )

        return model
    }
}

extension SportModel {
    func toSportResponseModel() -> SportResponseModel{
        let resModel = SportResponseModel(id: id, name: name, unit: unit)
        return resModel
    }
}


// MARK: Array
extension Array where Element == Sport {
    func toSportModels() -> [SportModel]{
        
        var models:[SportModel] = []
        for sport in self{
            models.append(sport.toSportModel())
        }
        
        return models
    }
}
