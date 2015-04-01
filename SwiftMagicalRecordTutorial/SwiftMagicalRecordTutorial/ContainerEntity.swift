//
//  ContainerEntity.swift
//  SwiftMagicalRecordTutorial
//
//  Created by Jovan Jovanovski on 11/3/14.
//  Copyright (c) 2014 SwiftPresenters. All rights reserved.
//

@objc(ContainerEntity)
class ContainerEntity: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var detailEntities: NSSet

}
