//
//  ViewController.swift
//  magicRecordTest
//
//  Created by andyhu on 15/3/12.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class ContainerEntityVC: UIViewController{//, UITableViewDataSource {

//    
//    @IBOutlet weak var textField: UITextField!
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    var containerEntites: [ContainerEntity]!
//        
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        containerEntites = ContainerEntity.findAll() as [ContainerEntity]
//    }
//    
//    @IBAction func saveButtonClicked() {
//        let containerEntity = ContainerEntity.createEntity() as ContainerEntity
//        containerEntity.name = textField.text
//        containerEntites.append(containerEntity)
//        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
//        textField.text = ""
//        tableView.reloadData()
//    }
//    
//    func tableView(tableView: UITableView,
//        numberOfRowsInSection section: Int) -> Int {
//            return containerEntites.count
//    }
//    
//    func tableView(tableView: UITableView,
//        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
//            cell.textLabel.text = containerEntites[indexPath.row].name
//            return cell
//    }
//    
//    func tableView(tableView: UITableView,
//        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//            return true
//    }
//    
//    func tableView(tableView: UITableView,
//        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
//        forRowAtIndexPath indexPath: NSIndexPath) {
//            if editingStyle == .Delete {
//                containerEntites.removeAtIndex(indexPath.row).deleteEntity()
//                NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
//                tableView.reloadData()
//            }
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let vc = segue.destinationViewController as DetailEntityVC
//        let containerEntity = containerEntites[tableView.indexPathForSelectedRow()!.row]
//        vc.containerEntity = containerEntity
//        vc.detailEntites = containerEntity.detailEntities.allObjects as Array
//    }
}

