//
//  DetailEntity.swift
//  magicRecordTest
//
//  Created by andyhu on 15/3/13.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import Foundation
import CoreData

class DetailEntity: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var containerEntities: ContainerEntity

}
