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
import SwiftRecord
import SwiftCSV
import SnapKit
import Haneke
import ReachabilitySwift

var CurrentTitle = "是的"

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var totalView: UIView!
    
    private let menuButtonLandscapeLeadingConstant: CGFloat = 1
    private let menuButtonPortraitLeadingConstant: CGFloat = 7
    private let hostNavigationBarHeightLandscape: CGFloat = 32
    private let hostNavigationBarHeightPortrait: CGFloat = 44
    var gad_view: GADViewController!
    var didSelectedRow = 0
    var erGes: [NSArray] = []
    var filteredErGes: [NSArray] = []

    var searchController: UISearchController!
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var video = VideoEntity.create(properties: ["name": "贝贝"]) as! VideoEntity
////        video.name = "小贝"
////        video.save()
//        var videos = VideoEntity.all() as![VideoEntity]
//        println(videos)
        
        let navBar = self.navigationController!.navigationBar
        

        let file = "er_ge.csv"
        var path = NSBundle.mainBundle().pathForResource("er_ge", ofType: "csv")
        let text2 = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
        var erGesLines = text2!.componentsSeparatedByString("\n")
        var line = ""
        for line in erGesLines {
            var splits = line.componentsSeparatedByString(";")
            if splits.count == 7{
                erGes.append(splits)
            }
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.showsCancelButton = true
        var cancelButton: UIButton
        var topView: UIView = self.searchController.searchBar.subviews[0] as! UIView
        for subView in topView.subviews {
            if subView.isKindOfClass(NSClassFromString("UINavigationButton")) {
                cancelButton = subView as! UIButton
                cancelButton.setTitle("取消", forState: UIControlState.Normal)
            }
        }
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.center.equalTo(self.view)
            make.height.equalTo(self.view.frame.height-40)
        }

        navBar.barTintColor = FlatUIColors.greenSeaColor(); //UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        gad_view = GADViewController(rootView: self, gad_type: 1)

        self.title = "儿歌"
        // Do any additional setup after loading the view.
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }


    func filterContentForSearchText(searchText: String) {
         filteredErGes = erGes.filter({ ( er_ge) -> Bool in
            let nameMatch = (er_ge[0] as! String).rangeOfString(searchText, options:
            NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil
        })
    }

    override func viewWillAppear(animated: Bool) {
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        //navigationController?.navigationBar.hidden = true // for navigation bar hide
        //UIApplication.sharedApplication().statusBarHidden=true; // for status bar hide
        self.tabBarController?.tabBar.hidden = false
        
        let reachability = Reachability.reachabilityForInternetConnection()
        // if isSearch {
        //     searchController.active = true
        // }
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        var message = ""
    }

    
    override func viewDidDisappear(animated: Bool) {
        
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewWillDisappear(animated: Bool) {
        //self.totalView?.setY(y: 80)
        
        //MTA.trackPageViewEnd("videosList")
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active{
            isSearch = true
            return filteredErGes.count
        }else{
            isSearch = false
            return erGes.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("videoTableCell", forIndexPath: indexPath) as! VideoTableViewCell
        var er_ge = []
       
        if searchController.active {
            er_ge = filteredErGes[indexPath.row]
        }
        else{
            er_ge = erGes[indexPath.row]
        }        
        cell.nameLabel.text = er_ge[0] as? String
        
        cell.playCountLabel.text = "播放:" + (er_ge[4] as? String)! + "次"
        var url = NSURL(string: er_ge[2] as! String)
        cell.picView.hnk_setImageFromURL(url!)
        cell.picView.contentMode = .ScaleAspectFill
        cell.picView.clipsToBounds = true
       
        cell.picView.layer.cornerRadius = 60/2
        cell.picView.layer.masksToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelectedRow = indexPath.row
        self.performSegueWithIdentifier("playVideoIdentifier", sender: self)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let statusbarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        //self.view.backgroundColor = UIColor(red: 65.0 / 255.0, green: 100.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        menuButton1?.frame = CGRectMake(menuButtonPortraitLeadingConstant, menuButtonPortraitLeadingConstant+statusbarHeight, 30.0, 30.0)
        menuButton1?.hidden = true
        //MTA.trackPageViewBegin("videosList")
        definesPresentationContext = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "setVideoTypeIdentifier"){
            let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
            destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
            destinationVC.hostTitleText = ""
            destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
            destinationVC.setMenuButtonWithImage(menuButton1.imageView!.image!)
        }else{
            let destinationVC = segue.destinationViewController as! VideoPlayerViewController

            destinationVC.er_ge = (searchController.active ? filteredErGes[didSelectedRow] : erGes[didSelectedRow])as! [String]
            destinationVC.er_ges = self.erGes
            destinationVC.currentIndexRow = didSelectedRow
            destinationVC.gad_view = gad_view
            self.tabBarController?.tabBar.hidden = true
            //searchController.active = false
            
            destinationVC.parentController = self
        }
    }

    func updateViewControllerFromChild(){
        searchController.active = false
    }
    
    @IBAction func didPickColorUnwind(segue: UIStoryboardSegue) {
        var sourceController = segue.sourceViewController as! GuillotineMenuViewController
        sourceController.closeMenuButtonTapped()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
