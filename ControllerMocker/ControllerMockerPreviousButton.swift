//
//  ControllerMockerPreviousButton.swift
//  ControllerMocker
//
//  Created by Marek Mechura on 20/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation


class ControllerMockerPreviousButton : ControllerMockerStepperButton {
    convenience init(keyWindow: UIWindow?, buttonPosition: CGRect? = nil) {
        self.init(keyWindow: keyWindow, buttonPosition: buttonPosition)
        
        self.setTitle("❰", forState: .Normal)
        self.addTarget(self, action: "nextStep:", forControlEvents: UIControlEvents.TouchUpInside)
    }
}