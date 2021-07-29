//
//  HistoryModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol HistoryModuleViewProtocol : class {
    
    var presenter: HistoryModulePresenterProtocol? {set get}
    
    // Add some methods here.
    
}

protocol HistoryModuleRouterProtocol: class {
    
    static func build() -> UIViewController

}

protocol HistoryModulePresenterProtocol: class {
    
    var view: HistoryModuleViewProtocol? {set get}
    var router: HistoryModuleRouterProtocol? {set get}
    var interactor: HistoryModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
    func loadRecordData() -> [RecordModel]
}

protocol HistoryModuleInteractorProtocol: class {
    
    func loadRecordData() -> [RecordModel]
    
}
