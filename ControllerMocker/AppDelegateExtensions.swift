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
    static func testViewControllers(window: UIWindow, controllers: [UIViewController], useStepper: Bool = true, delay: NSTimeInterval = 5) {
        
        let controllerMocker = ControllerMocker(window: window)
        controllerMocker.mockControllers(controllers, useStepper: useStepper, delay: delay)
    }
}
