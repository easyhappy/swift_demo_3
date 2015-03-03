//
//  ViewController.swift
//  test
//
//  Created by andyhu on 15/2/13.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.download(.GET, "http://httpbin.org/stream/100", { (temporaryURL, response) in
            if let directoryURL = NSFileManager.defaultManager()
                .URLsForDirectory(.DocumentDirectory,
                    inDomains: .UserDomainMask)[0]
                as? NSURL {
                    let pathComponent = response.suggestedFilename
                    
                    return directoryURL.URLByAppendingPathComponent(pathComponent!)
            }
            println("xiaobei")
            println(temporaryURL)
            return temporaryURL
        })
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)

        
        Alamofire.download(.GET, "http://httpbin.org/stream/100", destination)
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                println(totalBytesRead)
            }
            .response { (request, response, _, error) in
                println(response)
        }
        
        println("xiaobeiaaa")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

