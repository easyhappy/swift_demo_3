//
//  VideoViewController.swift
//  baoBaoErGe
//
//  Created by andyhu on 15/7/2.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import Persei
import FlatUIColors
import Alamofire

var CurrentTitle = "是的"
class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var totalView: UIView!
    
    private let menuButtonLandscapeLeadingConstant: CGFloat = 1
    private let menuButtonPortraitLeadingConstant: CGFloat = 7
    private let hostNavigationBarHeightLandscape: CGFloat = 32
    private let hostNavigationBarHeightPortrait: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = self.navigationController!.navigationBar
        
        navBar.barTintColor = FlatUIColors.greenSeaColor(); //UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    
//        var addStatusBar = UIView()
//        addStatusBar.frame = CGRectMake(0, 0, 320, 20);
//        addStatusBar.backgroundColor = FlatUIColors.greenSeaColor()
//        self.view.addSubview(addStatusBar)

        //tableView.addSubview(menu)
//        self.view.setY(y: 80)
        self.title = "1-2岁"
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(animated: Bool) {
        self.totalView?.setY(y: 80)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("videoTableCell", forIndexPath: indexPath) as! VideoTableViewCell
        cell.nameLabel.text = "1234"
        cell.picView.image = UIImage(named: "baobaoerge.png")
        cell.picView.contentMode = .ScaleAspectFill
        cell.picView.clipsToBounds = true
       
        cell.picView.layer.cornerRadius = 60/2
        cell.picView.layer.masksToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let statusbarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        //self.view.backgroundColor = UIColor(red: 65.0 / 255.0, green: 100.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        menuButton1?.frame = CGRectMake(menuButtonPortraitLeadingConstant, menuButtonPortraitLeadingConstant+statusbarHeight, 30.0, 30.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "setVideoTypeIdentifier"){
            let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
            destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
            destinationVC.hostTitleText = ""
            destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
            destinationVC.setMenuButtonWithImage(menuButton1.imageView!.image!)
        }else{
            
        }
    }
    
    @IBAction func didPickColorUnwind(segue: UIStoryboardSegue) {
        println("dafafadfadfa")
        var sourceController = segue.sourceViewController as! GuillotineMenuViewController
        sourceController.closeMenuButtonTapped()
        println("笑笑呗")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
