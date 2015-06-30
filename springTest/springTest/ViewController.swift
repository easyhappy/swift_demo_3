//
//  ViewController.swift
//  springTest
//
//  Created by andyhu on 15/6/16.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import Spring

class ViewController: UIViewController {

    @IBOutlet weak var imageView: SpringImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.animation = "squeezeDown"
        imageView.animate()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

