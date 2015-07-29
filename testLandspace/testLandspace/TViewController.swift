//
//  TViewController.swift
//  testLandspace
//
//  Created by andyhu on 15/7/29.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class TViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "test"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey: "orientation")
        //navigationController?.navigationBar.hidden = true // for navigation bar hide
        //UIApplication.sharedApplication().statusBarHidden=true; // for status bar hide
        //self.tabBarController?.tabBar.hidden = false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
}
