//
//  VideoViewController.swift
//  baoBaoErGe
//
//  Created by andyhu on 15/7/2.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit
import Persei
import FlatUIColors

class VideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuView()
        menu.backgroundColor = FlatUIColors.greenSeaColor()
        var item = MenuItem(image: UIImage(named: "video_40.png")!)
        menu.items = [item, item,item]
        tableView.addSubview(menu)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("game_videos", forIndexPath: indexPath) as! UITableViewCell
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
