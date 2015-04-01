//
//  DetailEntityVCViewController.swift
//  magicTest
//
//  Created by andyhu on 15/3/13.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class DetailEntityVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var containerEntity: ContainerEntity!
    
    var detailEntites: [DetailEntity]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = containerEntity.name
    }
    
    @IBAction func saveButtonClicked() {
        let detailEntity = DetailEntity.createEntity() as DetailEntity
        detailEntity.name = textField.text
        detailEntites.append(detailEntity)
        //containerEntity.detailEntities = NSSet(array: detailEntites)
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
        textField.text = ""
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
    return detailEntites.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
    //cell.textLabel.text = detailEntites[indexPath.row].name
    return cell
    }
    
    func tableView(tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                detailEntites.removeAtIndex(indexPath.row).deleteEntity()
                NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
                tableView.reloadData()
            }
    }
    
}