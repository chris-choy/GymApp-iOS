//
//  BottomTabBarController.swift
//  GymApp
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class BottomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let planNavigationController = UINavigationController(rootViewController: PlanListViewController(collectionViewLayout: UICollectionViewFlowLayout()))

        planNavigationController.tabBarItem.image = UIImage(named: "checklist")
//        planNavigationController.tabBarItem.title = "计划"
        
        
        let sportNavigationController = UINavigationController(rootViewController: SportViewController())
        sportNavigationController.tabBarItem.image = UIImage(named: "gym")
        sportNavigationController.tabBarItem.title = "运动"
        
        
        let startNavigationController = UINavigationController(rootViewController: SportViewController())
        startNavigationController.tabBarItem.image = UIImage(named: "run")
        startNavigationController.tabBarItem.title = "开始锻炼"
        
        let historyNavigationController = UINavigationController(rootViewController: SportViewController())
        historyNavigationController.tabBarItem.image = UIImage(named: "history")
        historyNavigationController.tabBarItem.title = "历史"
        
        let profileNavigationController = UINavigationController(rootViewController: SportViewController())
        profileNavigationController.tabBarItem.image = UIImage(named: "user")
        profileNavigationController.tabBarItem.title = "我的"
        
        viewControllers = [planNavigationController,
                           sportNavigationController,
                           startNavigationController,
                           historyNavigationController,
                           profileNavigationController]
        
    }
    
    @objc func addAction() {
        print("add")
//        sportList.append("test")
//        tableView.reloadData()
        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))
    }
    
}
