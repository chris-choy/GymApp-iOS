//
//  CustomFont.swift
//  GymApp
//
//  Created by Chris on 2022/1/13.
//  Copyright © 2022 Chris. All rights reserved.
//

import Foundation
import UIKit



//class GymFont : UIFont{
//    enum FontString: String {
//        case Copperplate_Light = "Copperplate-Light"
//    }
////
////    public enum size: CGFloat {
////        case Copperplate_Light = 11
////    }
//
////    init(name: FontString, size: CGFloat) {
////        super.init(name: FontString.Copperplate_Light.rawValue, size: 17)
////    }
//}

enum GymFontString: String {
    case PlanCollectionCellTitle,
         PlanCollectionCellDetail = "Copperplate-Light"
//    case PlanCollectionCellDetail = "Copperplate-Light"
}

enum GymFontSize: CGFloat {
    case PlanCollectionCellTitle = 21
    case PlanCollectionCellDetail = 18
}




extension UIFont {
    static func gymFont(size: GymFontSize, bold: Bool) -> UIFont {
        if (bold){
            return UIFont.boldSystemFont(ofSize: size.rawValue)
        } else {
            return UIFont.systemFont(ofSize: size.rawValue)
        }
        
        
    }
}
