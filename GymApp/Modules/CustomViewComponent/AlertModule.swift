//
//  AlertModule.swift
//  GymApp
//
//  Created by Chris on 2021/12/29.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

class AlertController {
    
    static func showConfirmCancelAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        
        return alert
        
    }
    
    static func showConfirmOnlyAlert(title: String, message: String, action: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: action))
        
        
        return alert
    }
    
    
}
