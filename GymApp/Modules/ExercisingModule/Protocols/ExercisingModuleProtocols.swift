//
//  ExercisingModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol ExercisingModuleViewProtocol : class {
    
    var presenter: ExercisingModulePresenterProtocol? {set get}
    
    // Add some methods here.
    
}

protocol ExercisingModuleRouterProtocol: class {
    
    static func build() -> UIViewController
    static func buildExercisingView(planMoldel: PlanModel) -> UIViewController

}

protocol ExercisingModulePresenterProtocol: class {
    
    var view: ExercisingModuleViewProtocol? {set get}
    var router: ExercisingModuleRouterProtocol? {set get}
    var interactor: ExercisingModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
    func createRecord(model: RecordModel) -> Bool
}

protocol ExercisingModuleInteractorProtocol: class {
    
    func createRecord(model: RecordModel) -> Bool
    
}
