//
//  ProfileModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol ProfileModuleViewProtocol : AnyObject {
    
    var presenter: ProfileModulePresenterProtocol? {set get}
    
}

protocol ProfileModuleRouterProtocol: AnyObject {
    
    static func build() -> UIViewController

}

protocol ProfileModulePresenterProtocol: AnyObject {
    
    var view: ProfileModuleViewProtocol? {set get}
    var router: ProfileModuleRouterProtocol? {set get}
    var interactor: ProfileModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
}

protocol ProfileModuleInteractorProtocol: AnyObject {
    
}
