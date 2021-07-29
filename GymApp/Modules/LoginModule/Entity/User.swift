//
//  User.swift
//  GymApp
//
//  Created by Chris on 2021/5/25.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation

struct User : Codable{
    var id: Int
    var name: String
    var username: String
    var age : Int
    var gender: Bool
}
