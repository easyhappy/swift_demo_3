//
//  ViewController.swift
//  GcdTest
//
//  Created by andyhu on 15/3/4.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var queue: dispatch_queue_t = dispatch_get_main_queue()
        
        dispatch_async(queue, {() -> Void in
            println("xiabeio")
        })
        
        println("beibei")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

