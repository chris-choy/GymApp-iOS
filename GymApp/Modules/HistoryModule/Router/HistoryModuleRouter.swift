//
//  HistoryModuleRouter.swift
//  GymApp
//
//  Created by Chris on 2020/10/31.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class HistoryModuleRouter: HistoryModuleRouterProtocol {
    
    static func build() -> UIViewController {
        
        // Use this method to create the module and the viewcontroller.
        
        let view = HistoryModuleView(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter : HistoryModulePresenterProtocol = HistoryModulePresenter()
        let router : HistoryModuleRouterProtocol = HistoryModuleRouter()
        let interactor: HistoryModuleInteractorProtocol = HistoryModuleInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
