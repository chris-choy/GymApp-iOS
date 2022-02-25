//
//  RequestError.swift
//  GymApp
//
//  Created by Chris on 2021/12/30.
//  Copyright © 2021 Chris. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case badRequest // 400
    case conflict // 409
    case unauthorized // 401
    case unknown
}
