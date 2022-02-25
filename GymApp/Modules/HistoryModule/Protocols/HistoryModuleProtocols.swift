//
//  HistoryModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol HistoryModuleViewProtocol : AnyObject {
    
    var presenter: HistoryModulePresenterProtocol? {set get}
    
    // Add some methods here.
    func showRecords(records: [RecordModel])
    func showErrorAlert()
    
}

protocol HistoryModuleRouterProtocol: AnyObject {
    
    static func build() -> UIViewController

}

protocol HistoryModulePresenterProtocol: AnyObject {
    
    var view: HistoryModuleViewProtocol? {set get}
    var router: HistoryModuleRouterProtocol? {set get}
    var interactor: HistoryModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
    
    func showRecords(records: [RecordModel])
    func getAllRecords()
    func showErrorAlert()
}

protocol HistoryModuleInteractorProtocol: AnyObject {
    
    var presenter: HistoryModulePresenterProtocol? {set get}
    
    func getAllRecords()
    
}
