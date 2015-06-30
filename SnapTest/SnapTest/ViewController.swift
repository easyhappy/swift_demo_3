//
//  ViewController.swift
//  SnapTest
//
//  Created by andyhu on 15/5/26.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import SnapKit
/**
    Extension UIView
    by DaRk-_-D0G
*/
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


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var v = UIView()
        v.backgroundColor = UIColor.blackColor()
        self.view.addSubview(v)
        // 思考 为什么 这里需要 传人hash
        v.setHeight(height: CGFloat(50))
        v.setWidth(width: CGFloat(50))
        v.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(20)
            make.bottom.greaterThanOrEqualTo(self.view).offset(-50)
            make.right.greaterThanOrEqualTo(self.view).offset(-50)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

