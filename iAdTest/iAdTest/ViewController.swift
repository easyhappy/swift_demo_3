//
//  ViewController.swift
//  iAdTest
//
//  Created by andyhu on 15/5/14.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import iAd
class ViewController: UIViewController, ADBannerViewDelegate {

    @IBOutlet weak var iad: ADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iad.delegate = self
        self.iad.frame = self.view.bounds
        self.canDisplayBannerAds = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        //self.ad.hidden = false
        println("成功")
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return willLeave
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        println("失败")
    }


}

