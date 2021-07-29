//
//  HistoryModuleEntity.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation


struct RecordModel {
    var planName: String
    var date : Date
    var totalTime: Int
    var recordSectionList: [RecordSectionModel]
}

struct RecordSectionModel{
    var sportName: String
    var sportUnit: String
    var recordRowList: [RecordRowModel]
}

struct RecordRowModel {
    let costTime : Int
    let times: Int
    let value: Float
}
