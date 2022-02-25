//
//  SceneDelegate.swift
//  GymApp
//
//  Created by Chris on 2020/4/16.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let vc = LoginModuleRouter.build()
        
        
        // ---------------------------测试使用---------------------------
        
        
//        var vc : UIViewController?
//        // 数据准备
//        // 用于测试PlanEditModule
//
//        let manager = PlanCoreDataManager()
//
//
//        if let plans = manager.fetchAllPlans() {
//
//            if plans.count != 0{
//
//                // 将数据载入VC
//                vc = ExercisingModuleView(planModel: plans[0].toPlanModel())
//            }
//
//
//
//        }
        
        
        // VC 选择
//        let vc = BottomTabBarController()
//        let vc = PickerVIewTeTableViewController()
//        let vc = SportViewController()
//        let vc = SportModuleView()
//        let vc = SportModuleRouter().buildSportModuleView()
//        let vc = ExercisingModuleView(planModel: <#T##PlanModel#>)
//        let vc = PlanTestVC()
//        let vc = NewPlanTestVC()
//        let vc = PlanEditView()
        

        let nav = UINavigationController(rootViewController: vc)
        // ---------------------------测试使用---------------------------

        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

