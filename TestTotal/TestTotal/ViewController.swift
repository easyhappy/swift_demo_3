//
//  ViewController.swift
//  TestTotal
//
//  Created by andyhu on 15/6/30.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import Alamofire
import MediaPlayer

class ViewController: UIViewController {
    var moviePlayer : MPMoviePlayerController!
    @IBOutlet weak var t: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doxxx(){
        var url = "http://121.18.214.232/43/2/84/bcloud/8795698-avc-261037-aac-32000-64100-2381510-55842b372384e6a2ccec87734c3201f0-1385565593407.letv?crypt=92aa7f2e119&b=296&nlh=3072&nlt=45&bf=32&p2p=1&video_type=mp4&termid=2&tss=no&geo=CN-2-0-132&platid=2&splatid=206&its=0&proxy=1987729156,1987729431,2007470979&keyitem=platid,splatid,its&ntm=1435656600&nkey=c2557da839d2db6083913964c8b14a23&nkey2=9c2e68ae5cdf298be8e652f677aab61e&mmsid=3503603&tm=1435638544&key=65062a1f907e8636435f1d4ff1214903&playid=0&vtype=21&cvid=1373091359853&payff=0&tag=mobile&sign=bcloud_100132&pay=0&ostype=android&hwtype=un&errc=0&gn=318&buss=59888&qos=2&cips=124.250.255.4"
        
        println("downloading....")
        var queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, {() -> Void in
            //var destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
            var destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
                (temporaryURL, response) in
                
                if let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as? NSURL {
                    return directoryURL.URLByAppendingPathComponent("haha.mp4")
                }
                
                return temporaryURL
            }
            Alamofire.download(.GET, url, destination).response{
                (request, response, _, error) in
                println(NSSearchPathDirectory.DocumentationDirectory)
                
                var paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                }.progress{
                    (bytesRead, totalBytesRead, expectedBytesRead) in
            }
        })
    }

    @IBAction func play(){
        let path = NSHomeDirectory() + "/Documents/" + "haha.mp4"

        let url = NSURL.fileURLWithPath(path)
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        if let player = self.moviePlayer {
           player.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
           player.view.sizeToFit()
           player.scalingMode = MPMovieScalingMode.Fill
           //player.fullscreen = true
           player.controlStyle = MPMovieControlStyle.None
           player.movieSourceType = MPMovieSourceType.File
           player.repeatMode = MPMovieRepeatMode.One
           player.play()
           self.view.addSubview(player.view)
        }
    }
}

