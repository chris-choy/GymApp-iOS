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
    
}

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
