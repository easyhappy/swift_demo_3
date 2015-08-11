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

extension NSFileManager{
    func addSkipBackupAttributeToItemAtURL(url:NSURL)->Bool{
        var error:NSError?
        let success:Bool = url.setResourceValue(true, forKey: NSURLIsExcludedFromBackupKey, error: &error);
        return success;
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

    
    var mainImageView: UIImageView!
    var tempImageView: UIImageView!
    
    var lastPoint = CGPoint.zeroPoint
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var EndTouch = true
    var TimerCount = 0
    var parentController: VideoViewController!
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        swiped = false
        if let touch = touches.first as? UITouch {
            lastPoint = touch.locationInView(self.view)
        }
        EndTouch = false
        TimerCount = 5
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        // 3
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        // 4
        CGContextStrokePath(context)
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        // 6
        swiped = true
        if let touch = touches.first as? UITouch {
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
            EndTouch = false
            TimerCount = 5
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
        EndTouch = true
        TimerCount = 5
    }
  
    
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
        mainImageView = UIImageView()
        mainImageView.frame = CGRectMake(0, 0, self.view.frame.height, self.view.frame.width)
        tempImageView = UIImageView()
        tempImageView.frame = CGRectMake(0, 0, self.view.frame.height, self.view.frame.width)
        setCurrentVideo()

        self.player = Player()
        self.player.delegate = self
        self.player.view.frame = CGRectMake(self.view.bounds.origin.y, self.view.bounds.origin.x, self.view.bounds.height, self.view.bounds.width+2)
        self.addChildViewController(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMoveToParentViewController(self)
        self.player.playbackLoops = false

        NSNotificationCenter.defaultCenter().addObserver(self, selector:"doYourStuff", name:
         UIApplicationWillEnterForegroundNotification, object: nil)
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("checkoutMainImageView"), userInfo: nil, repeats: true)

        self.view.addSubview(mainImageView)
        self.view.addSubview(tempImageView)
        updateParentViewController()
    }
    
    func updateParentViewController(){
        parentController.updateViewControllerFromChild()
    }

    func doYourStuff(){
        // self.view.autoresizingMask = (UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight)
         UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeRight.rawValue, forKey: "orientation")
         self.player?.playFromCurrentTime()
        // imageView.frame = CGRectMake(0, 0, self.view.frame.height, self.view.frame.width)
        // self.tabBarController?.tabBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        gad_view?.secondsDownTimer?.invalidate()
        self.player = nil
        MTA.trackPageViewEnd("videoPlay")
    }

    func checkoutMainImageView(){
        if EndTouch{
            if TimerCount < 0{
                self.mainImageView?.image = nil
                EndTouch = false
            }
        }
        TimerCount -= 1
    }

    func setCurrentVideo(){
        mainImageView?.image = nil
        (red, green, blue) = colors[randomInRange(0...(colors.count-1))]
        
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
                    self.fourColorCircularProgress?.progress = Double(1.0)
                    NSFileManager.defaultManager().addSkipBackupAttributeToItemAtURL(NSURL.fileURLWithPath(self.video_path)!);
                    UIView.animateWithDuration(0.1, animations: {
                        self.fourColorCircularProgress?.removeFromSuperview()
                        self.player?.path = self.video_path
                        self.player?.playFromBeginning()
                    })
                }else{
                    MTA.trackError("\(error)")
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
    
    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return Int(arc4random_uniform(count)) + range.startIndex
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
        }
        let touchPoint = touch.locationInView(self.gad_view)
        if touchPoint.y < self.gad_view.frame.height{
            return false
        }
        return true
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        MTA.trackPageViewBegin("videoPlay")
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
