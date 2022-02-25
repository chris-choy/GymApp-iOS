//
//  ExercisingModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/8/24.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol ExercisingModuleViewProtocol : AnyObject {
    
    var presenter: ExercisingModulePresenterProtocol? {set get}
    
    // Add some methods here.
    func showSuccessAlert()
    func showFailedAlert()
    
}

protocol ExercisingModuleRouterProtocol: AnyObject {
    
    static func buildExercisingView(planMoldel: PlanModel) -> UIViewController

}

protocol ExercisingModulePresenterProtocol: AnyObject {
    
    var view: ExercisingModuleViewProtocol? {set get}
    var router: ExercisingModuleRouterProtocol? {set get}
    var interactor: ExercisingModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
    func createRecord(model: RecordModel)
    
    func showSuccessAlert()
    func showFailedAlert()
    
}

protocol ExercisingModuleInteractorProtocol: AnyObject {
    
    var presenter: ExercisingModulePresenterProtocol? {set get}
    
    func createRecord(model: RecordModel)
    
}
