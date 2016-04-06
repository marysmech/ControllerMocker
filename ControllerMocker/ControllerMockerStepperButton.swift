//
//  ControllerMockerStepperButton.swift
//  cdrdiit
//
//  Created by Marek Mechura on 06/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation
import UIKit


class ControllerMockerStepperButton: UIButton {
    
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
        
        let button: CGRect
        
        if let buttonPosition = buttonPosition {
            button = buttonPosition
        }
        else {
            let rightX = (keyWindow?.frame.width)! - self.buttonProperties.visibleOffset
            let centerY = ((keyWindow?.frame.height)! - (self.buttonProperties.height/2))/2
            button = CGRect(x: rightX, y: centerY, width: self.buttonProperties.width, height: self.buttonProperties.height)
        }
        
        self.frame = button
        self.setTitle("❱", forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.backgroundColor = self.buttonProperties.normalBackgroundColor
        self.alpha = self.buttonProperties.clickAlpha
        self.addTarget(self, action: "nextStep:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    internal func nextStep(sender: ControllerMockerStepperButton!) {
        print("NEXT@@")
        self.showHideNextStepButton()
        
        controllerMockerDelegate?.showNextController(self)
    }
    
    override func layoutSubviews() {
        print("LAYOUT!!!")
        super.layoutSubviews()
        
        if UIDevice.currentDevice().orientation != self.orientation {
            self.updateButtonPositionAfterOrientationChange()
        }
    }
    
    private func updateButtonPositionAfterOrientationChange() {
        print("UIDEVICE")
        self.orientation = UIDevice.currentDevice().orientation
        
        let rightX = (superview!.frame.width) - self.buttonProperties.visibleOffset
        let centerY = ((superview!.frame.height) - (self.buttonProperties.height/2))/2
        self.center.x = rightX + (self.frame.width/2)
        self.center.y = centerY
        
        self.setNeedsDisplay()
    }
    
    
    internal func showHideNextStepButton() {
        print("DOUBLE!!")
        let moveOffsetX = self.frame.width - self.buttonProperties.visibleOffset
        
        print(buttonIsVisible)
        
        if buttonIsVisible {
            self.hideButton(moveOffsetX)
        }
        else {
            self.showButton(moveOffsetX)
        }
    }
    
    
    private func hideButton(moveOffsetX: CGFloat) {
        print("HIDE")
        UIView.animateWithDuration(0.3,
            animations: { _ in
                self.center.x = self.center.x + moveOffsetX
                self.alpha = self.buttonProperties.clickAlpha
            },
            completion: { finished in
                print("COMPET")
                self.buttonIsVisible = false
            }
        )
    }
    
    
    private func showButton(moveOffsetX: CGFloat) {
        print("SHOW")
        UIView.animateWithDuration(0.3,
            animations: { _ in
                self.center.x = self.center.x - moveOffsetX
                self.alpha = 1
                self.backgroundColor = self.buttonProperties.normalBackgroundColor
            },
            completion: { finished in
                self.buttonIsVisible = true
            }
        )
    }
}