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
        self.currentWindow.backgroundColor = UIColor.whiteColor()
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
        // present another controller in modal
        self.presentNextViewController(sender)
    }
    
    
    func showPreviousController(sender: ControllerMockerButton) {
        // present another controller in modal
        self.presentPreviousViewController(sender)
    }
    
    
    private func presentNextViewController(sender: ControllerMockerButton? = nil) {
        if self.numberOfPusherControllers < self.controllers.count {
            let controller = self.controllers[self.numberOfPusherControllers]
            
            self.presentGivenViewController(controller) {
                sender?.showHideNextStepButton()
                
                self.numberOfPusherControllers++
                self.showPreviousButtonIfNeeded()
                
                if self.numberOfPusherControllers >= self.controllers.count {
                    self.uiTestNextButton?.lockButton()
                }
            }
        }
    }
    
    
    private func presentPreviousViewController(sender: ControllerMockerButton? = nil) {
        if self.numberOfPusherControllers > 1 {
            let controller = self.controllers[(self.numberOfPusherControllers - 2)]
            
            self.presentGivenViewController(controller) {
                sender?.showHideNextStepButton()
                
                self.numberOfPusherControllers--
                self.unlockNextButtonIfNeeded()
                
                if (self.numberOfPusherControllers <= 1) {
                    self.uiTestPreviousButton?.lockButton()
                }
            }
        }
    }
    
    
    private func presentGivenViewController(controller: UIViewController, animated: Bool = true,  completion: (() -> Void)?) {
        // dismiss previous modal
        self.mainController.dismissViewControllerAnimated(animated, completion: nil)
        
        // present new controller in modal
        self.mainController.presentViewController(controller, animated: animated, completion: completion)
    }
    
    
    private func showPreviousButtonIfNeeded() {
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
        let alert = UIAlertController()
        alert.title = "Mocked Controllers"
        let message = NSMutableAttributedString(string: "")
        
        var cnt = 0
        for controller in self.controllers {
            var className = NSStringFromClass(controller.dynamicType)
            className = className.componentsSeparatedByString(".").last!
            
            if cnt == (self.numberOfPusherControllers - 1) {
                let activeControllerString = NSAttributedString(string: "\(className) \n", attributes: [
                    NSFontAttributeName: UIFont.systemFontOfSize(13),
                    NSForegroundColorAttributeName: UIColor.redColor()
                ])

                message.appendAttributedString(activeControllerString)
            }
            else {
                message.appendAttributedString(
                    NSAttributedString(string: "\(className) \n", attributes: [
                        NSFontAttributeName: UIFont.systemFontOfSize(12),
                    ])
                )
            }
            
            cnt++
        }
        
        alert.setValue(message, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default) { action in
            // load back previous controller
            let controller = self.controllers[(self.numberOfPusherControllers - 1)]
            self.presentGivenViewController(controller, animated: false, completion: nil)
        })
        
        self.presentGivenViewController(alert, animated: false, completion: nil)
    }
}