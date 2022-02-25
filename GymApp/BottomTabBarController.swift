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
        
        // ????
//        self.tabBar.barTintColor = .green
        // ????
        
        
        let planNavigationController = UINavigationController(rootViewController: PlanModuleRouter.buildPlanListView())
        
        planNavigationController.tabBarItem.image = UIImage(named: "checklist")
        planNavigationController.tabBarItem.title = "计划"
        
        
        let sportNavigationController = UINavigationController(rootViewController:SportModuleRouter().buildSportModuleView())
        sportNavigationController.tabBarItem.image = UIImage(named: "gym")
        sportNavigationController.tabBarItem.title = "运动"
        
        
        
        sportNavigationController.navigationBar.prefersLargeTitles = true
        
        /*
        let startNavigationController = UINavigationController(rootViewController:ExercisingModuleView())
        startNavigationController.tabBarItem.image = UIImage(named: "run")
        startNavigationController.tabBarItem.title = "开始锻炼"
        */
        
        let historyNavigationController = UINavigationController(rootViewController: HistoryModuleRouter.build())
        historyNavigationController.tabBarItem.image = UIImage(named: "history")
        historyNavigationController.tabBarItem.title = "历史"
        
        let profileNavigationController = UINavigationController(rootViewController: ProfileModuleRouter.build())
        profileNavigationController.tabBarItem.image = UIImage(named: "user")
        profileNavigationController.tabBarItem.title = "我的"
        
        viewControllers = [planNavigationController,
                           sportNavigationController,
//                           startNavigationController,
                           historyNavigationController,
                           profileNavigationController
        ]
        
        
        
        
        
        // test.
        selectedIndex = 1
        // test end.
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        <#code#>
//    }
    
    @objc func addAction() {
        print("add")
//        sportList.append("test")
//        tableView.reloadData()
        print(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))
    }
    
}
