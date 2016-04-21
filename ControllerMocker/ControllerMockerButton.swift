//
//  ControllerMockerButton.swift
//  ControllerMocker
//
//  Created by Marek Mechura on 20/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation
import UIKit


class ControllerMockerButton: UIButton {
    
    var buttonIsVisible = false
    var controllerMockerDelegate: ControllerMocker?
    var orientation: UIDeviceOrientation = UIDeviceOrientation.Portrait
    
    let buttonProperties = (
        width: 60 as CGFloat,
        height: 50 as CGFloat,
        normalBackgroundColor: UIColor.redColor(),
        activBackgroundColor: UIColor.grayColor(),
        clickAlpha: 0.1 as CGFloat,
        visibleOffset: 2 as CGFloat
    )
    
    
    convenience init(keyWindow: UIWindow?, buttonPosition: CGRect? = nil) {
        self.init()
        
        self.setButtonProperties(keyWindow, buttonPosition: buttonPosition)
    }
    
    
    func setButtonProperties(keyWindow: UIWindow?, buttonPosition: CGRect?) {
        fatalError("Missing implementation.")
    }
    
    func longPressed(sender: UILongPressGestureRecognizer) {
        print("longpressed")
    }
    
    
    internal func stepClick(sender: ControllerMockerButton!) {
        print("NEXT@@")
        self.showHideNextStepButton()
        
        controllerMockerDelegate?.showNextController(self)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if UIDevice.currentDevice().orientation != self.orientation {
            self.updateButtonPositionAfterOrientationChange()
        }
        
        self.becomeFirstResponder()
    }
    
    
    private func updateButtonPositionAfterOrientationChange() {
        self.orientation = UIDevice.currentDevice().orientation
        
        self.updateButtonPosition()
        
        self.setNeedsDisplay()
    }
    
    
    func updateButtonPosition() {
        fatalError("Missing implementation.")
    }
    
    
    func getMoveOffset() -> CGFloat {
        fatalError("Missing implementation.")
    }
    
    
    internal func showHideNextStepButton() {
        let moveOffset = getMoveOffset()
        
        print(buttonIsVisible)
        
        if !self.isLocked() {
            print("UNLOCKED")
            if buttonIsVisible {
                self.hideButton(moveOffset)
            }
            else {
                self.showButton(moveOffset)
            }
        }
        else {
            print("LOCKED - do nothing")
        }
    }
    
    func lockButton() {
        self.enabled = false
        self.alpha = self.buttonProperties.clickAlpha
    }
    
    func unlockButton() {
        self.enabled = true
        self.alpha = 1
    }
    
    func isLocked() -> Bool {
        if self.enabled {
            return false
        }
        
        return true
    }
    
    func hideButton(moveOffset: CGFloat) {
        fatalError("Missing implementation.")
    }
    
    
    func showButton(moveOffset: CGFloat) {
        fatalError("Missing implementation.")
    }
    
}
