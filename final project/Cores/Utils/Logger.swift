//
//  Logger.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import UIKit

class Logger: NSObject {
    
    static let enableLoging = false
    
    class func printLog(_ items: Any?) {
        if Logger.enableLoging {
            print(items ?? "=== printLog empty")
        }
    }
}
