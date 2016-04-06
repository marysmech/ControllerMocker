//
//  ControllerMocker.swift
//  cdrdiit
//
//  Created by Marek Mechura on 06/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation
import UIKit


public class ControllerMocker {
    
    let currentWindow: UIWindow
    let mainController: UIViewController
    var uiTestButton: ControllerMockerStepperButton?
    var numberOfPusherControllers: Int = 0
    var controllers = [UIViewController]()
    
    
    public init(window: UIWindow) {
        self.currentWindow = window
        self.mainController = UINavigationController()
        currentWindow.rootViewController = self.mainController
    }
    
    
    public func mockControllers(controllers: [UIViewController], useStepper: Bool = true, delay: NSTimeInterval = 5) {
        self.controllers = controllers
        
        if useStepper {
            print("USE STEPPER")
            self.uiTestButton = ControllerMockerStepperButton(keyWindow: currentWindow)
            self.uiTestButton?.controllerMockerDelegate = self
            self.uiTestButton?.showHideNextStepButton()
            currentWindow.addSubview(self.uiTestButton!)
        }
        
        self.presentGivenViewController()
        
        
        //        mainController.navigationController?.pushViewController(controllers.first!, animated: true)
        
        //        mainController.pushViewController(controllers.first, animated: true)
        
        //        var counter: NSTimeInterval = 0
        //        for controller in controllers {
        //            NSTimer.schedule(delay: (counter * delay) as NSTimeInterval, handler: { (timer) -> Void in
        //                navigationController.pushViewController(controller, animated: true)
        //            })
        //            counter++
        //        }
    }
    
    
    func showNextController(sender: ControllerMockerStepperButton) {
        print("####tapped!!!")
        print(sender)
        
        // dismiss previous modal
        self.mainController.dismissViewControllerAnimated(true, completion: nil)
        
        // present another controller in modal
        self.presentGivenViewController(sender)
    }
    
    
    private func presentGivenViewController(sender: ControllerMockerStepperButton? = nil) {
        
        if self.numberOfPusherControllers < self.controllers.count {
            let controller = self.controllers[self.numberOfPusherControllers]
            
            self.mainController.presentViewController(controller, animated: true) {
                sender?.showHideNextStepButton()
            }
            self.numberOfPusherControllers++
        }
    }
    
}