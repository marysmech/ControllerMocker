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
    var uiButtons: [ControllerMockerButton]?
    
    
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
//        self.uiTestPreviousButton?.showHideNextStepButton()
        currentWindow.addSubview(self.uiTestPreviousButton!)
        
        self.uiButtons = [self.uiTestNextButton!, self.uiTestPreviousButton!]
        
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
        print("####tapped PREV!!!")
        
        // present another controller in modal
        self.presentPreviousViewController(sender)
    }
    
    
    private func presentNextViewController(sender: ControllerMockerButton? = nil) {
        print("PUSHED: \(self.numberOfPusherControllers)")
        
        if self.numberOfPusherControllers < self.controllers.count {
            print("IF")
            let controller = self.controllers[self.numberOfPusherControllers]
            
            self.presentGivenViewController(sender, controller: controller) {
                sender?.showHideNextStepButton()
                
                self.numberOfPusherControllers++
                self.showPreviousButtonIfNeeded()
                
                if self.numberOfPusherControllers >= self.controllers.count {
                    print("LOCK NEXT")
                    self.uiTestNextButton?.lockButton()
                }
            }
            
            
        }
//        else {
//            print("ELSE")
//            self.uiTestNextButton?.lockButton()
//        }
    }
    
    
    private func presentPreviousViewController(sender: ControllerMockerButton? = nil) {
        print("PUSHED: \(self.numberOfPusherControllers)")
        
        
        if self.numberOfPusherControllers > 1 {
            print("IF")
            let controller = self.controllers[(self.numberOfPusherControllers - 2)]
            
            self.presentGivenViewController(sender, controller: controller) {
                sender?.showHideNextStepButton()
                
                self.numberOfPusherControllers--
                self.unlockNextButtonIfNeeded()
                
                if (self.numberOfPusherControllers <= 1) {
                    print("LOCK PREV")
                    self.uiTestPreviousButton?.lockButton()
                }
            }
        }
//        else {
//            print("ELSE")
//            self.uiTestPreviousButton?.lockButton()
//        }
    }
    
    
    private func presentGivenViewController(sender: ControllerMockerButton?, controller: UIViewController, completion: (() -> Void)) {
        // dismiss previous modal
        self.mainController.dismissViewControllerAnimated(true, completion: nil)
        
        // present new controller in modal
        self.mainController.presentViewController(controller, animated: true, completion: completion)
        
        
//        self.mainController.presentViewController(controller, animated: true) {
//            sender?.showHideNextStepButton()
//        }
    }
    
    
    private func showPreviousButtonIfNeeded() {
        print("showPreviousButtonIfNeeded")
        print("PREV BTN VISIBLE: \(self.uiTestPreviousButton!.buttonIsVisible)")
        print(self.numberOfPusherControllers)
        if self.numberOfPusherControllers > 1 {
            if !(self.uiTestPreviousButton!.buttonIsVisible) {
                self.uiTestPreviousButton?.showHideNextStepButton()
            }
            else if self.uiTestPreviousButton!.isLocked() {
                self.uiTestPreviousButton?.unlockButton()
            }
        }
    }
    
    
    private func unlockNextButtonIfNeeded() {
        if self.numberOfPusherControllers < self.controllers.count {
            if self.uiTestNextButton!.isLocked() {
                self.uiTestNextButton!.unlockButton()
            }
        }
    }
    
    func hideAllButtons() {
        for button in self.uiButtons! {
            button.hide()
        }
    }
    
    
    func showAllButtons() {
        for button in self.uiButtons! {
            button.show()
        }
    }
    
    func showPreviewOfAllMockedControllers() {
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        let alert = UIAlertController()
        alert.title = "Mocked Controllers"
        alert.message = "XXX"
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.mainController.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}