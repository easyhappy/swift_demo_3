//
//  ContainerEntity.swift
//  magicTest
//
//  Created by andyhu on 15/3/13.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

@objc(ContainerEntity)
class ContainerEntity: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var detailEntities: NSSet

}