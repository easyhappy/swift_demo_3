//
//  ViewController.swift
//  hybirdTest
//
//  Created by andyhu on 15/5/25.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad() // run base class viewDidLoad
        var url = NSURL(string:"http://jiaoyu.baidu.com/college/all?cityid=0&qid=1432525762552839711&pvid=1432525857132471696&zt=self&tn=NONE&pssid=0&queryTag=3") // make a URL
        var req = NSURLRequest(URL:url!) // make a request w/ that URL
        self.webView!.loadRequest(req) // unwrap the webView and load the request.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        super.loadView() // call parent loadView
        self.webView = WKWebView() // instantiate WKWebView
        self.view = self.webView! // make it the main view
    }


}

