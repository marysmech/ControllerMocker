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
        
        if buttonIsVisible {
            self.hideButton(moveOffset)
        }
        else {
            self.showButton(moveOffset)
        }
    }
    
    
    func hideButton(moveOffset: CGFloat) {
        fatalError("Missing implementation.")
    }
    
    
    func showButton(moveOffset: CGFloat) {
        fatalError("Missing implementation.")
    }
}
