//
//  MineViewController.swift
//  baoBaoErGe
//
//  Created by andyhu on 15/8/3.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutLabel.userInteractionEnabled = true
        var tagGesture = UITapGestureRecognizer(target: self, action: "aboutMeSelector")
        aboutLabel.addGestureRecognizer(tagGesture)

        moreLabel.userInteractionEnabled = true

        var moreTagGesture = UITapGestureRecognizer(target: self, action: "moreSelector")
        moreLabel.addGestureRecognizer(moreTagGesture)
//
//        commentLabel.userInteractionEnabled = true
//        var commentSelector = UITapGestureRecognizer(target: self, action: "commentSelector")
//        commentLabel.addGestureRecognizer(commentSelector)
//        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func commentSelector(){
        UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/us/app/yu-le2048/id1025703208迷ne?ls=1&mt=8")!)
    }

    func aboutMeSelector(){
        self.performSegueWithIdentifier("aboutMeIdentifier", sender: self)
    }

    func moreSelector(){
        self.performSegueWithIdentifier("moreIdentifier", sender: self)   
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
