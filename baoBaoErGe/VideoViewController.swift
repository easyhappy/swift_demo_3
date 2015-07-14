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

class VideoViewController: UIViewController{

    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuView()
        menu.backgroundColor = FlatUIColors.greenSeaColor()
        self.title = "是的么"
        var item = MenuItem(image: UIImage(named: "video_40.png")!)
       
        menu.items = [item, item,item]
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = FlatUIColors.greenSeaColor(); //UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.view.backgroundColor = UIColor(red: 65.0 / 255.0, green: 100.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        //tableView.addSubview(menu)

        // Do any additional setup after loading the view.
    }
//    
//    @objc protocol GuillotineAnimationProtocol: NSObjectProtocol {
//        func navigationBarHeight() -> CGFloat
//        func anchorPoint() -> CGPoint
//        func hostTitle () -> NSString
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! GuillotineMenuViewController
        destinationVC.hostNavigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        destinationVC.hostTitleText = "是的"
        destinationVC.view.backgroundColor = self.navigationController!.navigationBar.barTintColor
        destinationVC.setMenuButtonWithImage(menuButton1.imageView!.image!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
