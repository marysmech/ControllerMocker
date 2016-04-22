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
    /**
     Load given UIViewControllers and allow switch among them like in slideshow.
     
     - Parameters:
     - window: App main window.
     - controllers: Array of UIViewController to load.
     */
    public static func testViewControllers(window: UIWindow, controllers: [UIViewController]) {
        let controllerMocker = ControllerMocker(window: window)
        controllerMocker.mockControllers(controllers)
    }
    
    
    /**
     Load given UIViewControllers and show them in automatic slideshow.
     
     - Parameters:
     - window: App main window.
     - controllers: Array of UIViewController to load.
     - delay: Time interval to stay on every screen before switch to another.
     */
    public static func testViewControllersWithTimer(window: UIWindow, controllers: [UIViewController], delay: NSTimeInterval = 5) {
        
        let controllerMocker = ControllerMocker(window: window)
        controllerMocker.mockControllersWithTimer(controllers, delay: delay)
    }
}
