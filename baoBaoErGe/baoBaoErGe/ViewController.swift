//
//  ViewController.swift
//  DrawPad
//
//  Created by Jean-Pierre Distler on 13.11.14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit
import FlatUIColors

class ViewController: UIViewController, SphereMenuDelegate {
    
    var mainImageView: UIImageView!
    var tempImageView: UIImageView!
    
    var lastPoint = CGPoint.zeroPoint
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var currentIndex = 0
    var blackPen: UIImageView!
    var greyPen: UIImageView!
    var redPen: UIImageView!
    var bluePen: UIImageView!
    var lightBluePen: UIImageView!
    var darkGreenPen: UIImageView!
    var lightGreenPen: UIImageView!
    var brownPen: UIImageView!
    var darkOrangePen: UIImageView!
    var yellowPen: UIImageView!
    var eraserPen: UIImageView!
    var colorPens: [String: UIImageView]!
    var currentPen: String = ""
    

    let colors: [(String, CGFloat, CGFloat, CGFloat)] = [("blackPen", 0, 0, 0), ("greyPen", 105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
                ("redPen", 1.0, 0, 0), ("bluePen", 0, 0, 1.0), ("lightBluePen", 51.0 / 255.0, 204.0 / 255.0, 1.0), 
                ("darkGreenPen", 102.0 / 255.0, 204.0 / 255.0, 0), ("lightGreenPen", 102.0 / 255.0, 1.0, 0),
                ("brownPen", 160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0), ("darkOrangePen", 1.0, 102.0 / 255.0, 0), ("yellowPen", 1.0, 1.0, 0), ("eraserPen", 1.0, 1.0, 1.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let start = UIImage(named: "start")
        let image1 = UIImage(named: "quse")
        let image2 = UIImage(named: "iphoto")
        let image3 = UIImage(named: "setting")
        let image4 = UIImage(named: "empty")
        let image5 = UIImage(named: "weixin")
        let image6 = UIImage(named: "home_icon")

        var images:[UIImage] = [image1!, image2!, image3!, image4!, image5!, image6!]
        var menu = SphereMenu(startPoint: CGPointMake(self.view.frame.width/2, self.view.frame.height-80), startImage: start!, submenuImages:images, tapToDismiss:true)
        menu.delegate = self
        self.view.addSubview(menu)
        self.tabBarController?.tabBar.hidden = true
        addPens()
        // tempImageView.snp_makeConstraints { (make) -> Void in
        //    make.width.equalTo(self.view.frame.size.width)
        //    make.height.equalTo(self.view.frame.size.height)

        //    make.top.equalTo(self.view).offset(0)
        //    make.left.equalTo(self.view).offset(0)
        //    make.bottom.equalTo(self.view).offset(0)
        //    make.right.equalTo(self.view).offset(0)
        // }
        mainImageView = UIImageView()
        self.view.addSubview(mainImageView)
        
        tempImageView = UIImageView()
        self.view.addSubview(tempImageView)

        mainImageView.frame = CGRectMake(0 , 0, self.view.frame.width, self.view.frame.height)
        tempImageView.frame = CGRectMake(0 , 0, self.view.frame.width, self.view.frame.height)
        currentPen = "blackPen"
        initPenPosition()
//        mainImageView.snp_makeConstraints { (make) -> Void in
//           make.width.equalTo(self.view.frame.size.width)
//           make.height.equalTo(self.view.frame.size.height)
//
//           make.top.equalTo(self.view).offset(0)
//           make.left.equalTo(self.view).offset(0)
//           make.bottom.equalTo(self.view).offset(0)
//           make.right.equalTo(self.view).offset(0)
//        }
    }

    func addPens(){
        var width = CGFloat(80)
        var height = CGFloat(30)
        var xOffset = self.view.frame.width - CGFloat(width)
        var yOffset = height + CGFloat(40)
        blackPen = UIImageView(image: UIImage(named: "Black"))
        blackPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(blackPen)
        yOffset = yOffset + height

        greyPen = UIImageView(image: UIImage(named: "Grey"))
        greyPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(greyPen)
        yOffset = yOffset + height

        redPen = UIImageView(image: UIImage(named: "Red"))
        redPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(redPen)

        yOffset = yOffset + height

        bluePen = UIImageView(image: UIImage(named: "Blue"))
        bluePen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(bluePen)

        yOffset = yOffset + height
        
        lightBluePen = UIImageView(image: UIImage(named: "LightBlue"))
        lightBluePen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(lightBluePen)

        yOffset = yOffset + height

        darkGreenPen = UIImageView(image: UIImage(named: "DarkGreen"))
        darkGreenPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(darkGreenPen)

        yOffset = yOffset + height

        lightGreenPen = UIImageView(image: UIImage(named: "LightGreen"))
        lightGreenPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(lightGreenPen)

        yOffset = yOffset + height

        brownPen = UIImageView(image: UIImage(named: "Brown"))
        brownPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(brownPen)

        yOffset = yOffset + height

        darkOrangePen = UIImageView(image: UIImage(named: "DarkOrange"))
        darkOrangePen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(darkOrangePen)

        yOffset = yOffset + height

        yellowPen = UIImageView(image: UIImage(named: "Yellow"))
        yellowPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(yellowPen)

        yOffset = yOffset + height

        eraserPen = UIImageView(image: UIImage(named: "Eraser"))
        eraserPen.frame = CGRectMake(xOffset, yOffset, width, height)
        self.view.addSubview(eraserPen)

        colorPens = ["blackPen": blackPen, "greyPen": greyPen, "redPen": redPen, "bluePen": bluePen, "lightBluePen": lightBluePen, 
                    "darkGreenPen": darkGreenPen, "lightGreenPen": lightGreenPen, 
                    "brownPen": brownPen, "darkOrangePen": darkOrangePen, "yellowPen": yellowPen, "eraserPen": eraserPen]

         var blacktapGesture = UITapGestureRecognizer(target: self, action:  "blackPentapGesture:")
         blackPen.addGestureRecognizer(blacktapGesture)
         blackPen.userInteractionEnabled = true

         var greytapGesture = UITapGestureRecognizer(target: self, action:  "greyPentapGesture:")
         greyPen.addGestureRecognizer(greytapGesture)
         greyPen.userInteractionEnabled = true

        var redtapGesture = UITapGestureRecognizer(target: self, action:  "redPentapGesture:")
        redPen.addGestureRecognizer(redtapGesture)
        redPen.userInteractionEnabled = true

         var bluetapGesture = UITapGestureRecognizer(target: self, action:  "bluePentapGesture:")
         bluePen.addGestureRecognizer(bluetapGesture)
         bluePen.userInteractionEnabled = true

         var lightBluetapGesture = UITapGestureRecognizer(target: self, action:  "lightBluePentapGesture:")
         lightBluePen.addGestureRecognizer(lightBluetapGesture)
         lightBluePen.userInteractionEnabled = true
         
         var darkGreentapGesture = UITapGestureRecognizer(target: self, action:  "darkGreenPentapGesture:")
         darkGreenPen.addGestureRecognizer(darkGreentapGesture)
         darkGreenPen.userInteractionEnabled = true

         var lightGreentapGesture = UITapGestureRecognizer(target: self, action:  "lightGreenentapGesture:")
         lightGreenPen.addGestureRecognizer(lightGreentapGesture)
         lightGreenPen.userInteractionEnabled = true

         var browntapGesture = UITapGestureRecognizer(target: self, action:  "brownPentapGesture:")
         brownPen.addGestureRecognizer(browntapGesture)
         brownPen.userInteractionEnabled = true

         var darkOrangetapGesture = UITapGestureRecognizer(target: self, action:  "darkOrangePentapGesture:")
         darkOrangePen.addGestureRecognizer(darkOrangetapGesture)
         darkOrangePen.userInteractionEnabled = true

         var yellowtapGesture = UITapGestureRecognizer(target: self, action:  "yellowPentapGesture:")
         yellowPen.addGestureRecognizer(yellowtapGesture)
         yellowPen.userInteractionEnabled = true

         var eraserapGesture = UITapGestureRecognizer(target: self, action:  "eraserPentapGesture:")
         eraserPen.addGestureRecognizer(eraserapGesture)
         eraserPen.userInteractionEnabled = true
    }

    func blackPentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("blackPen")
    }

    func greyPentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("greyPen")
    }

    func redPentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("redPen")
    }

    func bluePentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("bluePen")
    }

    func lightBluePentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("lightBluePen")
    }

    func darkGreenPentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("darkGreenPen")
    }

    func lightGreenentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("lightGreenPen")
    }

    func brownPentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("brownPen")
    }

    func darkOrangePentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("eraserdarkOrangePen")
    }

    func yellowPentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("yellowPen")
    }

    func eraserPentapGesture(gesture: UIGestureRecognizer) {
        pentapGesture("eraserPen")
    }
    

    func pentapGesture(colorPen: String){
        //currentColor = color
        currentPen = colorPen
        for color in colors{
            (currentPen, red, green, blue) = color
            if currentPen == colorPen{
                for (key, pen) in colorPens{
                    if key == currentPen{
                        pen.frame.origin.x = self.view.frame.width - CGFloat(80)
                    }
                    else {
                        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
                            pen.frame.origin.x = self.view.frame.width
                            }, completion: { (finished: Bool) in
                        });
                    }
                }
                return
            }
        }
        
    }

    func initPenPosition(){
        var localPen = ""
        for color in colors{
            (localPen, red, green, blue) = color
            if currentPen == localPen{
                for (key, pen) in colorPens{
                    if key == currentPen{
                        pen.frame.origin.x = self.view.frame.width - CGFloat(80)
                    }
                    else {
                        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
                            pen.frame.origin.x = self.view.frame.width
                            }, completion: { (finished: Bool) in
                        });
                    }
                }
                return
            }
        }
    }

    func sphereDidSelected(index: Int) {
        switch  index {
        case 0:
            var width = self.view.frame.width
            for (key, pen) in colorPens{
                UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
                    pen.frame.origin.x = width - CGFloat(80)
                    }, completion: { (finished: Bool) in
                });
            }
        case 3:
            mainImageView.image = nil
        default:
            println("default")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func reset(sender: AnyObject) {
        mainImageView.image = nil
    }
    
    @IBAction func share(sender: AnyObject) {
        UIGraphicsBeginImageContext(mainImageView.bounds.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0,
            width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(activity, animated: true, completion: nil)
    }
    
    @IBAction func pencilPressed(sender: AnyObject) {
        
//        var index = sender.tag ?? 0
//        if index < 0 || index >= colors.count {
//            index = 0
//        }
//        
//        (red, green, blue) = colors[index]
//        
//        if index == colors.count - 1 {
//            opacity = 1.0
//        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        swiped = false
        if let touch = touches.first as? UITouch {
            lastPoint = touch.locationInView(self.view)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true

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
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(view.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(currentIndex == 3){       
            let settingsViewController = segue.destinationViewController as! SettingsViewController
            settingsViewController.delegate = self
            settingsViewController.brush = brushWidth
            settingsViewController.opacity = opacity
            settingsViewController.red = red
            settingsViewController.green = green
            settingsViewController.blue = blue
        }
    }
    
}

extension ViewController: SettingsViewControllerDelegate {
    func settingsViewControllerFinished(settingsViewController: SettingsViewController) {
        self.brushWidth = settingsViewController.brush
        self.opacity = settingsViewController.opacity
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
    }
}

