//
//  Extends.swift
//  baoBaoErGe
//
//  Created by andyhu on 15/7/15.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
    Set x Position
    
    :param: x CGFloat
    by DaRk-_-D0G
    */
    func setX(#x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    /**
    Set y Position
    
    :param: y CGFloat
    by DaRk-_-D0G
    */
    func setY(#y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    /**
    Set Width
    
    :param: width CGFloat
    by DaRk-_-D0G
    */
    func setWidth(#width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    /**
    Set Height
    
    :param: height CGFloat
    by DaRk-_-D0G
    */
    func setHeight(#height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}


