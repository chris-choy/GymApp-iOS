//
//  PlanSection.swift
//  GymApp
//
//  Created by Chris on 2020/6/29.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

struct PlanSectionModel: Codable {
    var id : Int
    var seq: Int16
    let unit: String
    var rowList: [PlanRowModel] = []
    let sport: SportModel
    let last_changed: Int
    let plan_id: Int

    enum CodingKeys: String, CodingKey{
        case id = "id"
        case seq = "seq"
        case rowList = "rowList"
        case sport = "sport"
        case last_changed = "last_changed"
        case plan_id = "plan_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        seq = try container.decode(Int16.self, forKey: .seq)
        rowList = try container.decode([PlanRowModel].self, forKey: .rowList)
        sport = try container.decode(SportModel.self, forKey: .sport)
        unit = sport.unit
        last_changed = try container.decode(Int.self, forKey: .last_changed)
        plan_id = try container.decode(Int.self, forKey: .plan_id)
    }
    
    init(id: Int,
         seq: Int16,
         unit: String,
         rowList: [PlanRowModel],
         sport: SportModel,
         last_changed: Int,
         plan_id: Int) {
        
        self.id = id
        self.seq = seq
        self.unit = unit
        self.rowList = rowList
        self.sport = sport
        self.last_changed = last_changed
        self.plan_id = plan_id
    }

}
