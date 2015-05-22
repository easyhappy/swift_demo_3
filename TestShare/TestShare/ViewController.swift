//
//  ViewController.swift
//  TestShare
//
//  Created by andyhu on 15/5/19.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var share: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func t(sender: UIButton) {
        var publishContent : ISSContent = ShareSDK.content("分享文字", defaultContent:"默认分享内容，没内容时显示",image:nil, title:"提示",url:"返回链接",description:"这是一条测试信息",mediaType:SSPublishContentMediaTypeNews)
        ShareSDK.showShareActionSheet(nil, shareList: nil, content: publishContent, statusBarTips: true, authOptions: nil, shareOptions: nil, result: {(type:ShareType,state:SSResponseState,statusInfo:ISSPlatformShareInfo!,error:ICMErrorInfo!,end:Bool) in
            println(state.value)
            if (state.value == SSResponseStateSuccess.value){
                println("分享成功")
                var alert = UIAlertView(title: "提示", message:"分享成功", delegate:self, cancelButtonTitle: "ok")
                alert.show()
            }
            else {if (state.value == 2) {
                var alert = UIAlertView(title: "提示", message:"您没有安装客户端，无法使用分享功能！", delegate:self, cancelButtonTitle: "ok")
                alert.show()
                println(error.errorCode())
                println(error.errorDescription())
                println()
                }
            }
        })
    }


}

