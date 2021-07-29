//
//  ProfileModuleProtocols.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

protocol ProfileModuleViewProtocol : class {
    
    var presenter: ProfileModulePresenterProtocol? {set get}
    
    // Add some methods here.
    
}

protocol ProfileModuleRouterProtocol: class {
    
    static func build() -> UIViewController

}

protocol ProfileModulePresenterProtocol: class {
    
    var view: ProfileModuleViewProtocol? {set get}
    var router: ProfileModuleRouterProtocol? {set get}
    var interactor: ProfileModuleInteractorProtocol? {set get}
    
    func viewDidLoad()
}

protocol ProfileModuleInteractorProtocol: class {
    
    
    
}
