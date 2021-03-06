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
            let centerY = ((keyWindow?.frame.height)! - (self.buttonProperties.height/2))/2
            button = CGRect(x: leftX, y: centerY, width: self.buttonProperties.width, height: self.buttonProperties.height)
        }
        
        self.frame = button
        self.setTitle("❰", forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.backgroundColor = self.buttonProperties.normalBackgroundColor
        self.alpha = self.buttonProperties.clickAlpha
        self.addTarget(self, action: "stepClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        self.addGestureRecognizer(longPressRecognizer)
        
        let doubleTappedRecognizer = UITapGestureRecognizer(target: self, action: "doubleTapped")
        doubleTappedRecognizer.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTappedRecognizer)
    }
    
    
    internal override func stepClick(sender: ControllerMockerButton!) {
        self.showHideNextStepButton()
        
        controllerMockerDelegate?.showPreviousController(self)
    }
    
    
    override func updateButtonPosition() {
        let leftX = self.buttonProperties.width/2
        let centerY = ((superview!.frame.height) - (self.buttonProperties.height/2))/2
        self.center.x = leftX
        self.center.y = centerY
    }
    
    
    override func getMoveOffset() -> CGFloat {
        return self.buttonProperties.width - self.buttonProperties.visibleOffset
    }
    
    
    override func hideButton(moveOffset: CGFloat) {
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
