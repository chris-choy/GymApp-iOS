//
//  HistoryModuleEntity.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation


struct RecordModel : Codable {
    
    var id : Int
    var planName: String
    var date : Date
    var totalTime: Int
    var recordSectionList: [RecordSectionModel]
    
    enum CodingKeys: String, CodingKey{
        case planName = "plan_name"
        case date = "date"
        case recordSectionList = "recordSectionList"
        case id = "id"
        case totalTime = "total_time"
    }
    
    init(id:Int, planName: String, date: Date, totalTime: Int, recordSectionList: [RecordSectionModel]) {
        self.planName = planName
        self.date = date
        self.totalTime = totalTime
        self.recordSectionList = recordSectionList
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        planName = try container.decode(String.self, forKey: .planName)
        
        // The timestamp data from sever is milliseconds.
        let milliseconds = try container.decode(Double.self, forKey: .date)
        // Transform the milliseconds into seconds.
        date = Date(timeIntervalSince1970: milliseconds/1000)
        
        recordSectionList = try container.decode([RecordSectionModel].self, forKey: .recordSectionList)
        totalTime = try container.decode(Int.self, forKey: .totalTime)
        id = try container.decode(Int.self, forKey: .id)
        
    }
    

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(planName, forKey: .planName)
        try container.encode(date, forKey: .date)
        try container.encode(recordSectionList, forKey: .recordSectionList)
        try container.encode(0, forKey: .id)
        try container.encode(totalTime, forKey: .totalTime)
    }
    
}


struct RecordSectionModel : Codable{
    var sportName: String
    var sportUnit: String
    var recordRowList: [RecordRowModel]
    
    enum CodingKeys: String, CodingKey{
        case sportName = "sport_name"
        case sportUnit = "sport_unit"
        case recordRowList = "rowList"
        case id = "id"
    }
    
    init(sportName: String, sportUnit: String, recordRowList: [RecordRowModel]) {
        self.sportName = sportName
        self.sportUnit = sportUnit
        self.recordRowList = recordRowList
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sportName = try container.decode(String.self, forKey: .sportName)
        sportUnit = try container.decode(String.self, forKey: .sportUnit)
        recordRowList = try container.decode([RecordRowModel].self, forKey: .recordRowList)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(sportName, forKey: .sportName)
        try container.encode(sportUnit, forKey: .sportUnit)
        try container.encode(recordRowList, forKey: .recordRowList)
        try container.encode(0, forKey: .id)
    }

}

struct RecordRowModel : Codable{
    
    let costTime : Int
    let times: Int
    let value: Float
//    let date: Date
    
    
    enum CodingKeys: String, CodingKey{
        case costTime = "cost_time"
        case times = "times"
        case value = "value"
//        case date = "date"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        costTime = try container.decode(Int.self, forKey: .costTime)
        times = try container.decode(Int.self, forKey: .times)
//        totalTime = try container.decode(Int.self, forKey: .totalTime)
        value = try container.decode(Float.self, forKey: .value)
//        date = try container.decode(Date.self, forKey: .date)
    }
    
    init(costTime: Int, times: Int, value: Float) {
        self.costTime = costTime
        self.times = times
        self.value = value
//        self.date = date
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(costTime, forKey: .costTime)
        try container.encode(times, forKey: .times)
        try container.encode(value, forKey: .value)
//        try container.encode(date, forKey: .date)
        try container.encode(0, forKey: .id)
    }
    
}
