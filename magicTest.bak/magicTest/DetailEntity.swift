//
//  DetailEntity.swift
//  magicTest
//
//  Created by andyhu on 15/3/13.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

@objc(DetailEntity)
class DetailEntity: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var containerEntity: ContainerEntity
    
}