//
//  Colors.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/08/22.
//

import UIKit

enum ColorEnum {
    case bg
    case black10
    case black20
    case black40
    case black70
    case primary
}

class Color: NSObject {
    class func getColor(name: ColorEnum) -> UIColor? {
        switch name {
        case .bg:
            return UIColor(named: "Bg")
        case .black10:
            return UIColor(named: "Black10")
        case .black20:
            return UIColor(named: "Black20")
        case .black40:
            return UIColor(named: "Black40")
        case .black70:
            return UIColor(named: "Black70")
        case .primary:
            return UIColor(named: "Primary")
            
        }
    }
}
