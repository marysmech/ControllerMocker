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
    var uiTestNextButton: ControllerMockerButton?
    var uiTestPreviousButton: ControllerMockerButton?
    var numberOfPusherControllers: Int = 0
    var controllers = [UIViewController]()
    
    
    public init(window: UIWindow) {
        self.currentWindow = window
        self.mainController = UINavigationController()
        currentWindow.rootViewController = self.mainController
    }
    
    
    public func mockControllers(controllers: [UIViewController]) {
        self.controllers = controllers
        self.numberOfPusherControllers = 0
        
        self.uiTestNextButton = ControllerMockerButtonNext(keyWindow: currentWindow)
        self.uiTestNextButton?.controllerMockerDelegate = self
        self.uiTestNextButton?.showHideNextStepButton()
        currentWindow.addSubview(self.uiTestNextButton!)
        
        self.uiTestPreviousButton = ControllerMockerButtonPrevious(keyWindow: currentWindow)
        self.uiTestPreviousButton?.controllerMockerDelegate = self
        self.uiTestPreviousButton?.showHideNextStepButton()
        currentWindow.addSubview(self.uiTestPreviousButton!)
        
        self.presentNextViewController()
    }
    
    
    public func mockControllersWithTimer(controllers: [UIViewController], delay: NSTimeInterval = 5) {
        self.controllers = controllers
        self.numberOfPusherControllers = 0
        
        var counter: NSTimeInterval = 0
        for _ in controllers {
            NSTimer.schedule(delay: (counter * delay) as NSTimeInterval, handler: { (timer) -> Void in
                self.presentNextViewController()
            })
            counter++
        }
    }
    
    
    func showNextController(sender: ControllerMockerButton) {
        print("####tapped NEXT!!!")
        
        // present another controller in modal
        self.presentNextViewController(sender)
    }
    
    func showPreviousController(sender: ControllerMockerButton) {
        // TODO
        
        
        print("####tapped PREV!!!")
        
        // present another controller in modal
        self.presentPreviousViewController(sender)
    }
    
    
//    private func presentGivenViewController(sender: ControllerMockerButton? = nil) {
//        
//        if self.numberOfPusherControllers < self.controllers.count {
//            let controller = self.controllers[self.numberOfPusherControllers]
//            
//            // dismiss previous modal
//            self.mainController.dismissViewControllerAnimated(true, completion: nil)
//            
//            // present new controller in modal
//            self.mainController.presentViewController(controller, animated: true) {
//                sender?.showHideNextStepButton()
//            }
//            self.numberOfPusherControllers++
//        }
//    }
    
    private func presentNextViewController(sender: ControllerMockerButton? = nil) {
        
        if self.numberOfPusherControllers < self.controllers.count {
            let controller = self.controllers[self.numberOfPusherControllers]
            
            self.presentGivenViewController(sender, controller: controller)
            
            self.numberOfPusherControllers++
        }
    }
    
    
    private func presentPreviousViewController(sender: ControllerMockerButton? = nil) {
        
        print("NUM OF PUSHED: \(self.numberOfPusherControllers)")
        
        if self.numberOfPusherControllers > 1 {
            print("INDEX TO PUSH: \(self.numberOfPusherControllers - 2)")
            
            
            let controller = self.controllers[(self.numberOfPusherControllers - 2)]
            
            self.presentGivenViewController(sender, controller: controller)
            
            self.numberOfPusherControllers--
        }
    }
    
    
    private func presentGivenViewController(sender: ControllerMockerButton?, controller: UIViewController) {
        // dismiss previous modal
        self.mainController.dismissViewControllerAnimated(true, completion: nil)
        
        // present new controller in modal
        self.mainController.presentViewController(controller, animated: true) {
            sender?.showHideNextStepButton()
        }
    }
    
    
    
}