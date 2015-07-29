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
    var video_path = ""
    var video_name = ""
    var alamofireManager : Alamofire.Manager?
    var er_ge: [String] = []
    var currentIndexRow = 0
    var er_ges: [NSArray] = []
    var gad_view: GADViewController!
    var imageView: UIImageView!

    @IBOutlet private weak var storyboardCircularProgress: KYCircularProgress!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey: "orientation")
        
        self.view.autoresizingMask = (UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight)
        
        var backgroundImage = UIImage(named: "clouds.png")
        imageView = UIImageView()
        imageView.frame = CGRectMake(0, 0, self.view.frame.height, self.view.frame.width)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        //imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        setCurrentVideo()
        self.player = Player()
        self.player.delegate = self
        self.player.view.frame = CGRectMake(self.view.bounds.origin.y, self.view.bounds.origin.x, self.view.bounds.height, self.view.bounds.width+2)
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        self.player.playbackLoops = false
        self.player.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"doYourStuff", name:
         UIApplicationWillEnterForegroundNotification, object: nil)
    }

    func doYourStuff(){
        // self.view.autoresizingMask = (UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight)
         UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey: "orientation")
         self.player.playFromCurrentTime()
        // imageView.frame = CGRectMake(0, 0, self.view.frame.height, self.view.frame.width)
        // self.tabBarController?.tabBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        gad_view.secondsDownTimer.invalidate()
    }

    func setCurrentVideo(){
        self.title = er_ge[0]
        if self.er_ge[6].rangeOfString("%2F") != nil{
            video_name = self.er_ge[6].componentsSeparatedByString("%2F").last!
        }else{
            video_name = self.er_ge[6].componentsSeparatedByString("/").last!
        }
        //video_name = "mama.mp4"
        video_path = NSHomeDirectory() + "/Documents/" + video_name
        var checkValidation = NSFileManager.defaultManager()

        
        if (checkValidation.fileExistsAtPath(video_path)){
            gad_view.showGAD(self)
            self.view.addSubview(gad_view)   
        }
        else{
            configureFourColorCircularProgress()
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.timeoutIntervalForResource = 600 // seconds
            
            self.alamofireManager = Alamofire.Manager(configuration: configuration)
            
            var destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
            alamofireManager!.download(.GET, self.er_ge[6], destination: destination).response{
                (request, response, _, error) in
                if (error == nil){
                    println(NSSearchPathDirectory.DocumentationDirectory)
                    self.fourColorCircularProgress.progress = Double(1.0)

                    UIView.animateWithDuration(0.1, animations: {
                        self.fourColorCircularProgress.removeFromSuperview()
                        self.player.path = self.video_path
                        self.player.playFromBeginning()
                    })
                }else{
                    println("小贝")
                }
                
                }.progress{
                    (bytesRead, totalBytesRead, expectedBytesRead) in
                    println(totalBytesRead)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                            // update some UI
                        let ratio: CGFloat = CGFloat(totalBytesRead)*1.0 / CGFloat(expectedBytesRead)
                        self.fourColorCircularProgress.progress = Double(ratio)
                    }
            }
        }
    }

    func playVideo(){
        self.player.path = self.video_path
        self.player.playFromBeginning()
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view .isKindOfClass(GADViewController){
            println("xiaobei")
        }
        let touchPoint = touch.locationInView(self.gad_view)
        if touchPoint.y < self.gad_view.frame.height{
            return false
        }
        return true
        //        if CGRectContainsPoint(self.gameboard.bounds, touchPoint){
        //            let centerX = CGRectGetMidX(self.gameboard.bounds)
        //            let centerY = CGRectGetMidY(self.gameboard.bounds)
        //            let xy2 = pow(centerX - touchPoint.x, 2.0) + pow(centerY - touchPoint.y, 2.0)
        //            let radius2 = pow(CGRectGetWidth(self.gameboard.frame)/2,2)
        //            if xy2 < radius2{
        //                return true
        //            }
        //        }
        //        return false
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        


        //navigationController?.navigationBar.hidden = true // for navigation bar hide
        //UIApplication.sharedApplication().statusBarHidden=true;
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
        let fourColorCircularProgressFrame = CGRectMake(0, 0, 120, 120)
        fourColorCircularProgress = KYCircularProgress(frame: fourColorCircularProgressFrame)
        
        fourColorCircularProgress.frame.origin.x = self.view.frame.height/2 - CGRectGetMidX(fourColorCircularProgressFrame)
        fourColorCircularProgress.frame.origin.y = self.view.frame.width/2 - CGRectGetMidY(fourColorCircularProgressFrame)
        fourColorCircularProgress.lineWidth = 8.0
        fourColorCircularProgress.colors = [UIColor(rgba: 0xA6E39D11), UIColor(rgba: 0xAEC1E355), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xF3C0ABFF)]
        
        view.addSubview(fourColorCircularProgress)
        //self.view.backgroundColor = UIColor(patternImage: !)
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
    
    func playerPlaybackDidEnd(player: Player){
        currentIndexRow += 1
        if currentIndexRow >= er_ges.count{
            currentIndexRow = 0
        }
        er_ge = er_ges[currentIndexRow] as! [String]
        setCurrentVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
