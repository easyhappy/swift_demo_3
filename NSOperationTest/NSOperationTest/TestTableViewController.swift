//
//  TestTableViewController.swift
//  NSOperationTest
//
//  Created by andyhu on 15/3/7.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    var photos = [NSIndexPath: Photo]()
    let pendingOperations = PendingOperations()
    var imageUrls = ["http://e.hiphotos.baidu.com/image/pic/item/0e2442a7d933c895b5142e32d21373f082020014.jpg", "http://e.hiphotos.baidu.com/image/pic/item/0e2442a7d933c895b5142e32d21373f082020014.jpg"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 100
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("a", forIndexPath: indexPath) as UITableViewCell


        if (photos[indexPath] == nil){
            photos[indexPath] = Photo(name: "小贝", url: NSURL(string: "http://e.hiphotos.baidu.com/image/pic/item/0e2442a7d933c895b5142e32d21373f082020014.jpg")!)
        }
        
        cell.textLabel.text = "是的"
        cell.imageView.image = photos[indexPath]!.image
        startDownloadForRecord(photos[indexPath]!, indexPath: indexPath)
        return cell
    }
    
    
    func startDownloadForRecord(photo: Photo, indexPath: NSIndexPath){
        if var downloadOperation = pendingOperations.downloadsInProgress[indexPath]{
            return
        }
        
        let downloader = ImageDownloader(photo: photo)
        
        downloader.completionBlock = {
            println("我已经完成了\(indexPath)")
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        //4
        pendingOperations.downloadsInProgress[indexPath] = downloader
        //5
        pendingOperations.downloadQueue.addOperation(downloader)
        
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
