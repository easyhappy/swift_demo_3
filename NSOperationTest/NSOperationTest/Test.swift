//
//  Test.swift
//  NSOperationTest
//
//  Created by andyhu on 15/3/7.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import Foundation
import UIKit

enum PhotoState{
    case New, Downloaded
}

class Photo{
    let name: String
    let url: NSURL
    var state = PhotoState.New
    var image = UIImage(named: "1.png")
    
    init(name: String, url: NSURL){
        self.name = name
        self.url = url
    }
}

class PendingOperations{
    lazy var downloadsInProgress = [NSIndexPath: NSOperation]()
    lazy var downloadQueue: NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "xiaobei"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class ImageDownloader: NSOperation{
    let photo: Photo!
    init(photo: Photo){
        self.photo = photo
    }
    
    override func main(){
        if self.photo.state == PhotoState.Downloaded{
            return
        }
        let imageData = NSData(contentsOfURL: self.photo.url)
        if imageData?.length > 0 {
            self.photo.image = UIImage(data:imageData!)
            self.photo.state = PhotoState.Downloaded
            println("是的")
        }

    }
}