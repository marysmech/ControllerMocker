//
//  ControllerMockerButtonPrevious.swift
//  ControllerMocker
//
//  Created by Marek Mechura on 20/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation
import UIKit


class ControllerMockerButtonPrevious: ControllerMockerButton, ControllerMockerButtonProtocol {
    
    override func setButtonProperties(keyWindow: UIWindow?, buttonPosition: CGRect?) {
        let button: CGRect
        
        if let buttonPosition = buttonPosition {
            button = buttonPosition
        }
        else {
            let leftX = 0 - (self.buttonProperties.width - self.buttonProperties.visibleOffset)
            
            print("WIDTH: \(self.buttonProperties.width)")
            print("LEFTX: \(leftX)")
            
            let centerY = ((keyWindow?.frame.height)! - (self.buttonProperties.height/2))/2
            button = CGRect(x: leftX, y: centerY, width: self.buttonProperties.width, height: self.buttonProperties.height)
        }
        
        self.frame = button
        self.setTitle("❰", forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.backgroundColor = self.buttonProperties.normalBackgroundColor
        self.alpha = self.buttonProperties.clickAlpha
        self.addTarget(self, action: "stepClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    internal override func stepClick(sender: ControllerMockerButton!) {
        print("PREV@@")
        self.showHideNextStepButton()
        
        controllerMockerDelegate?.showPreviousController(self)
    }
    
    
    override func updateButtonPosition() {
        let leftX = 0 + self.buttonProperties.width
        
        print("UPDATE LEFTX: \(leftX)")
        
        let centerY = ((superview!.frame.height) - (self.buttonProperties.height/2))/2
        self.center.x = leftX
        self.center.y = centerY
    }
    
    
    override func getMoveOffset() -> CGFloat {
        return self.buttonProperties.visibleOffset
    }
    
    
    override func hideButton(moveOffset: CGFloat) {
        print("HIDE BUTTON")
        print("CENTER.X: \(self.center.x)")
        print("MOVEOFFSET: \(moveOffset)")
        print("RES: \(self.center.x - moveOffset)")
        
        
        UIView.animateWithDuration(0.3,
            animations: { _ in
                self.center.x = self.center.x - moveOffset
                self.alpha = self.buttonProperties.clickAlpha
            },
            completion: { finished in
                self.buttonIsVisible = false
            }
        )
    }
    
    
    override func showButton(moveOffset: CGFloat) {
        print("SHOW BUTTON")
        print("CENTER.X: \(self.center.x)")
        print("MOVEOFFSET: \(moveOffset)")
        print("RES: \(self.center.x + moveOffset)")
        
        
        UIView.animateWithDuration(0.3,
            animations: { _ in
                self.center.x = self.center.x + moveOffset
                self.alpha = 1
                self.backgroundColor = self.buttonProperties.normalBackgroundColor
            },
            completion: { finished in
                self.buttonIsVisible = true
            }
        )
    }
}
