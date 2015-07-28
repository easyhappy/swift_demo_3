

//
//  TViewController.swift
//  TestAD
//
//  Created by andyhu on 15/7/28.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class TViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var gad_view = GADViewController(rootView: self)
        self.view.addSubview(gad_view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func supportedInterfaceOrientations() -> Int {
//        return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
//    }
//    
//    override func shouldAutorotate() -> Bool {
//        return false
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey: "orientation")
//        //navigationController?.navigationBar.hidden = true // for navigation bar hide
//        //UIApplication.sharedApplication().statusBarHidden=true
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
