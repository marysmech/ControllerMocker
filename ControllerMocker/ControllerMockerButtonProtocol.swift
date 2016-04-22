//
//  ControllerMockerButtonProtocol.swift
//  ControllerMocker
//
//  Created by Marek Mechura on 20/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation

protocol ControllerMockerButtonProtocol {
    func setButtonProperties(keyWindow: UIWindow?, buttonPosition: CGRect?)
    func updateButtonPosition()
    func getMoveOffset() -> CGFloat
    func hideButton(moveOffset: CGFloat)
    func showButton(moveOffset: CGFloat)
}
