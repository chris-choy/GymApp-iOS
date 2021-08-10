//
//  PlanRowCoreDataManagement.swift
//  GymApp
//
//  Created by Chris on 2020/6/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData


struct PlanRowModel: Codable {
    
    let id: Int
    
    var seq: Int
    var lastValue : Float = 0 // 暂时还没用上,故默认给个0.
    var value : Float
    var times: Int
    
    var restTime: Int = 0
    
    var last_changed : Int
    var plan_id : Int
    var plan_section_id : Int

    
//    "id": 9,
//    "plan_id": 4,
//    "plan_section_id": 7,
//    "seq": 1,
//    "value": 1111.0,
//    "times": 11,
//    "restTime": 2,
//    "lastValue": 1,
//    "last_changed": 1626685285000
    
    
}


//struct PlanRowResponseModel: Codable {
//    var id: Int
//    var plan_section_id: Int
//    var seq: Int
//    var value : Float
//
//}

//extension PlanRowModel {
//    func toPlanRowResponseModel(plan_section_id: Int, seq: Int) -> PlanRowResponseModel {
//        let resModel = PlanRowResponseModel(id: id,
//                                            plan_section_id: plan_section_id,
//                                            seq: seq,
//                                            value: value)
//        
//        return resModel
//    }
//}
//
//extension Array where Element == PlanRowModel{
//    func toPlanRowResponseModels(plan_section_id: Int) -> [PlanRowResponseModel]{
//        
//        var resList : [PlanRowResponseModel] = []
//    
//        for seq in 1 ... count {
////            resList.append(self.toPlanRowResponseModel(plan_section_id: , seq: seq))
//            resList.append(self[seq-1].toPlanRowResponseModel(plan_section_id: plan_section_id, seq: seq))
//        }
//        
//        return resList
//    }
//}


extension PlanRow {
    func toPlanRowModel() -> PlanRowModel{
        let model = PlanRowModel(
            id: Int(self.id),
            seq: Int(self.seq),
            lastValue: self.lastValue,
            value: self.value,
            times: Int(self.times),
            restTime: Int(self.restTime),
            last_changed : Int(self.last_changed),
            plan_id : Int(self.plan_id),
            plan_section_id : Int(self.plan_section_id))
        return model
    }
}





