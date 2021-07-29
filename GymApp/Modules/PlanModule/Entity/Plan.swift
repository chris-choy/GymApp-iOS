//
//  PlanEditEntity.swift
//  GymApp
//
//  Created by Chris on 2020/6/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

// #MARK: Model
struct PlanModel : Codable{
    let id: Int
    let objectId : NSManagedObjectID?
    var name : String
    var sectionList: [PlanSectionModel] = []
    var last_changed : Int
    var seq: Int
    let user_id: Int
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case sectionList = "sectionList"
        case objectId = "objectId"
        case last_changed = "last_changed"
        case seq = "seq"
        case user_id = "user_id"
    }
    
    
    func encode(to encoder: Encoder) throws {
//        enum CodingKeys: String, CodingKey{
//            case id = "id"
//            case name = "name"
//            case sectionList = "sectionList"
//        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sectionList, forKey: .sectionList)
        try container.encode(seq, forKey: .seq)
        try container.encode(last_changed, forKey: .last_changed)
        try container.encode(user_id, forKey: .user_id)
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sectionList = try container.decode([PlanSectionModel].self, forKey: .sectionList)
        last_changed = try container.decode(Int.self, forKey: .last_changed)
        objectId = nil
        seq = try container.decode(Int.self, forKey: .seq)
        user_id = try container.decode(Int.self, forKey: .seq)
    }
    
    init(id: Int,
         objectId:NSManagedObjectID?,
         name:String,
         sectionList: [PlanSectionModel],
         last_changed: Int,
         seq: Int,
         user_id: Int) {
        self.id = id
        self.name = name
        self.sectionList = sectionList
        self.last_changed = last_changed
        self.objectId = objectId
        self.seq = seq
        self.user_id = user_id
    }
    
//    init() {
//        let plan = PlanModel(id: self.id, objectId: nil, name: name, sectionList: planSectionList, last_changed: last_changed)
//    }
    
    
    
    
    
}

//struct PlanResponseModel: Codable{
////    let objectId : NSManagedObjectID
//    
//    var id : Int
//    var name : String
//    var sectionList: [PlanSectionResponseModel]
//    var seq: Int
//    var user_id : Int
//    var last_changed : Int
// 
//}
//
//extension PlanResponseModel {
//    func toPlanModel() -> PlanModel {
//        
//        // Create Section.
//        var planSectionList : [PlanSectionModel] = []
//        for section in sectionList {
//            var rowList : [PlanRowModel] = []
//            for row in section.rowList{
//                // Create Row.
//                let planRow = PlanRowModel(
//                    id: row.id,
//                    seq: row.seq,
//                    lastValue: 0,
//                    value: row.value,
//                    times: 1, restTime: 0)
//                
//                // Add into rowList.
//                rowList.append(planRow)
//            }
//            
//            let sport = SportModel(id: section.sport.id, objectId: nil, name: section.sport.name, unit: SportUnitModel(name: section.sport.name, sportNames: nil))
//            
//            let planSection = PlanSectionModel(
//                id: 0,
//                seq: Int16(section.seq),
//                unit: section.sport.unit,
//                rowList: rowList,
//                sport: sport)
//            
//            planSectionList.append(planSection)
//        }
//        
//        
//        // Create Plan.
//        let plan = PlanModel(id: self.id, objectId: nil, name: name, sectionList: planSectionList, last_changed: last_changed, seq: seq)
//        
//        return plan
//    }
//}




//extension PlanModel {
//    func toPlanResponseModel() -> PlanResponseModel{
//        
//        let resModel = PlanResponseModel(id: id ?? 0,
//                                         name: name,
//                                         sectionList: sectionList.toPlanSectionResponseModel(plan_id: id ?? 0),
//                                         seq: 0,
//                                         user_id: 0,
//                                         last_changed: 0)
//        
//        return resModel
//    }
//}


extension Array where Element == Plan {
    func toPlanModels() -> [PlanModel]{

        var models:[PlanModel] = []
        for plan in self{
            models.append(plan.toPlanModel())
        }

        return models
    }
}




