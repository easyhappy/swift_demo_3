//
//  VideoPlayerViewController.swift
//  baoBaoErGe
//
//  Created by andyhu on 15/7/20.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import Player
import Alamofire
import KYCircularProgress
import GradientCircularProgress
import FlatUIColors
import Spring

public class MyStyle : Style {
    
    override init() {
        super.init()
        /*** style properties **********************************************************************************/
        // Progress Size
        self.progressSize = 200
        
        // Gradient Circular
        self.arcLineWidth = 18.0
        self.startArcColor = UIColor.darkGrayColor()
        self.endArcColor = UIColor.greenColor()
        
        // Base Circular
        self.baseLineWidth = 19.0
        self.baseArcColor = UIColor.darkGrayColor()
        
        // Percentage
        self.ratioLabelFont = UIFont(name: "Verdana-Bold", size: 16.0)!
        self.ratioLabelFontColor = UIColor.whiteColor()
        
        // Message
        self.messageLabelFont = UIFont.systemFontOfSize(16.0)
        self.messageLabelFontColor = UIColor.whiteColor()
        
        // Background
        self.backgroundStyle = .Dark
        /*** style properties **********************************************************************************/
    }
}

class VideoPlayerViewController: UIViewController, PlayerDelegate{
    private var player: Player!
    private var halfCircularProgress: KYCircularProgress!
    private var fourColorCircularProgress: KYCircularProgress!
    private var starProgress: KYCircularProgress!
    private var progress: UInt8 = 0
    @IBOutlet private weak var storyboardCircularProgress: KYCircularProgress!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        var destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        //var gcp = GCProgress()
        
         //self.player.path = "test.mp4"
        self.view.autoresizingMask = (UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight)
        self.player = Player()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.player.delegate = self
        self.player.view.frame = self.view.bounds
        
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        self.player.playbackLoops = true
        self.player.path = "http://7nj0n6.com1.z0.glb.clouddn.com/videosTrickorTreat.mp4"
        //self.player.playFromBeginning()
        println("走到viewDidLoad")
        configureHalfCircularProgress()
//        configureFourColorCircularProgress()
//        configureStarProgress()


        // create KYCircularProgress with gauge guide
        //var circularProgress = KYCircularProgress(frame: self.view.bounds, showProgressGuide: true)
        Alamofire.download(.GET, "http://7xjh8x.com1.z0.glb.clouddn.com/uploads/test.mp4", destination).response{
            (request, response, _, error) in
            println(NSSearchPathDirectory.DocumentationDirectory)
                self.halfCircularProgress.progress = Double(1.0)

                UIView.animateWithDuration(0.1, animations: {
                    self.halfCircularProgress.removeFromSuperview()
                    self.player.playFromBeginning()
                })
            
            }.progress{
                (bytesRead, totalBytesRead, expectedBytesRead) in
                println(totalBytesRead)
                
                dispatch_async(dispatch_get_main_queue()) {
                        // update some UI
                    let ratio: CGFloat = CGFloat(totalBytesRead)*1.0 / CGFloat(expectedBytesRead)
                    self.halfCircularProgress.progress = Double(ratio)
                    
                    self.view.addSubview(self.halfCircularProgress)
                        
                }
                
        }
    }
    
    
    
    private func configureHalfCircularProgress() {
        let halfCircularProgressFrame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        halfCircularProgress = KYCircularProgress(frame: halfCircularProgressFrame)
        
        let center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        halfCircularProgress.path = UIBezierPath(arcCenter: center, radius: CGFloat(CGRectGetWidth(halfCircularProgress.frame)/3), startAngle: CGFloat(M_PI), endAngle: CGFloat(0.0), clockwise: true)
        halfCircularProgress.colors = [UIColor(rgba: 0xA6E39DAA), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xF3C0ABAA)]
        halfCircularProgress.lineWidth = 8.0
        halfCircularProgress.showProgressGuide = true
        halfCircularProgress.progressGuideColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        
        let textLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2-90, self.view.frame.size.height/2-20, 180, 32.0))
        textLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 32)
        textLabel.textAlignment = .Center
        textLabel.textColor = UIColor.greenColor()
        textLabel.alpha = 0.9
        halfCircularProgress.addSubview(textLabel)
        halfCircularProgress.backgroundColor = FlatUIColors.cloudsColor()
        halfCircularProgress.progressChangedClosure() {
            (progress: Double, circularView: KYCircularProgress) in
            println("progress: \(progress)")
            textLabel.text = "已缓冲\(Int(progress * 100.0))%"
        }
        
        view.addSubview(halfCircularProgress)
    }
    
    private func configureFourColorCircularProgress() {
        let fourColorCircularProgressFrame = CGRectMake(0, CGRectGetHeight(halfCircularProgress.frame), CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)/3)
        fourColorCircularProgress = KYCircularProgress(frame: fourColorCircularProgressFrame)
        
        fourColorCircularProgress.colors = [UIColor(rgba: 0xA6E39D11), UIColor(rgba: 0xAEC1E355), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xF3C0ABFF)]
        
        view.addSubview(fourColorCircularProgress)
    }
    
    private func configureStarProgress() {
        let starProgressFrame = CGRectMake(CGRectGetWidth(fourColorCircularProgress.frame)*1.25, CGRectGetHeight(halfCircularProgress.frame)*1.15, CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)/2)
        starProgress = KYCircularProgress(frame: starProgressFrame)
        
        starProgress.colors = [UIColor.purpleColor(), UIColor(rgba: 0xFFF77A55), UIColor.orangeColor()]
        starProgress.lineWidth = 3.0
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(50.0, 2.0))
        path.addLineToPoint(CGPointMake(84.0, 86.0))
        path.addLineToPoint(CGPointMake(6.0, 33.0))
        path.addLineToPoint(CGPointMake(96.0, 33.0))
        path.addLineToPoint(CGPointMake(17.0, 86.0))
        path.closePath()
        starProgress.path = path
        
        view.addSubview(starProgress)
    }
    
    func updateProgress() {
        progress = progress &+ 1
        let normalizedProgress = Double(progress) / 255.0
        
        halfCircularProgress.progress = normalizedProgress
        fourColorCircularProgress.progress = normalizedProgress
        starProgress.progress = normalizedProgress
        storyboardCircularProgress.progress = normalizedProgress
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.player.playFromBeginning()
    }
    
    func playerReady(player: Player){
        println("是的")
    }
    
    
    
    func playerPlaybackStateDidChange(player: Player){}
    func playerBufferingStateDidChange(player: Player){}
    
    func playerPlaybackWillStartFromBeginning(player: Player){}
    func playerPlaybackDidEnd(player: Player){}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
