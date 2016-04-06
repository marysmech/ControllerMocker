//
//  AppDelegateExtensions.swift
//  ControllerMocker
//
//  Created by Marek Mechura on 07/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation
import UIKit

extension UIApplicationDelegate {
    public static func testViewControllers(window: UIWindow, controllers: [UIViewController]) {
        
        let controllerMocker = ControllerMocker(window: window)
        controllerMocker.mockControllers(controllers)
    }
    
    
    public static func testViewControllersWithTimer(window: UIWindow, controllers: [UIViewController],delay: NSTimeInterval = 5) {
        
        let controllerMocker = ControllerMocker(window: window)
        controllerMocker.mockControllersWithTimer(controllers, delay: delay)
    }
}
