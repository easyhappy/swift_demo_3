//
//  ContainerEntity.swift
//  magicRecordTest
//
//  Created by andyhu on 15/3/13.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import Foundation
import CoreData

class ContainerEntity: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var detailEntities: NSSet

}
