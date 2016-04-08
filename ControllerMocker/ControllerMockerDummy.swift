//
//  ControllerMockerDummy.swift
//  ControllerMocker
//
//  Created by Marek Mechura on 08/04/16.
//  Copyright © 2016 Marek Mechura. All rights reserved.
//

import Foundation


class ControllerMockerDummy {
    public static func getUrlToDummyImage() -> String {
        return ControllerMockerDummy().getPathDummyImageOrDummyUrl()
    }
    
    func getPathToDummyImage() -> String? {
        let bundle = NSBundle(forClass: ControllerMockerDummy.self)
        let pathToDummyImage = bundle.URLForResource("dummy", withExtension: "png")
        
        if let pathToDummyImage = pathToDummyImage {
            return pathToDummyImage.absoluteString
        }
        
        return nil
    }
    
    func getPathDummyImageOrDummyUrl() -> String {
        var imageUrl = "http://img.example.com/1"
        
        let pathToDummyImage = self.getPathToDummyImage()
        
        if let pathToDummyImage = pathToDummyImage {
            imageUrl = pathToDummyImage
        }
        
        return imageUrl
    }
}