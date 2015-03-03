//
//  ViewController.swift
//  downloadFile
//
//  Created by andyhu on 15/3/2.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func downloadPdf()
    {
        var request = NSURLRequest(URL: NSURL(string: "http://www.sa.is/media/1039/example.pdf")!)
        let session = AFHTTPSessionManager()
        
        var progress: NSProgress?
        
        var downloadTask = session.downloadTaskWithRequest(request, progress: &progress, destination: {(file, responce) in self.pathUrl},
            completionHandler:
            {
                response, localfile, error in
                println("response \(response)")
        })
        
        downloadTask.resume()
    }
    
    var pathUrl: NSURL
        {
            let folder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let path = folder.stringByAppendingPathComponent("file.pdf")
            let url = NSURL(fileURLWithPath: path)
            return url!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

