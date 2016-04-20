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
    var uiTestButton: ControllerMockerButtonNext?
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
        
        self.uiTestButton = ControllerMockerButtonNext(keyWindow: currentWindow)
        self.uiTestButton?.controllerMockerDelegate = self
        self.uiTestButton?.showHideNextStepButton()
        currentWindow.addSubview(self.uiTestButton!)
        
        self.presentGivenViewController()
    }
    
    
    public func mockControllersWithTimer(controllers: [UIViewController], delay: NSTimeInterval = 5) {
        self.controllers = controllers
        self.numberOfPusherControllers = 0
        
        var counter: NSTimeInterval = 0
        for _ in controllers {
            NSTimer.schedule(delay: (counter * delay) as NSTimeInterval, handler: { (timer) -> Void in
                self.presentGivenViewController()
            })
            counter++
        }
    }
    
    
    func showNextController(sender: ControllerMockerButton) {
        print("####tapped!!!")
        
        // present another controller in modal
        self.presentGivenViewController(sender)
    }
    
    
    private func presentGivenViewController(sender: ControllerMockerButton? = nil) {
        
        if self.numberOfPusherControllers < self.controllers.count {
            let controller = self.controllers[self.numberOfPusherControllers]
            
            // dismiss previous modal
            self.mainController.dismissViewControllerAnimated(true, completion: nil)
            
            // present new controller in modal
            self.mainController.presentViewController(controller, animated: true) {
                sender?.showHideNextStepButton()
            }
            self.numberOfPusherControllers++
        }
    }
    
}