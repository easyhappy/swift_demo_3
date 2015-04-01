//
//  DetailEntity.swift
//  SwiftMagicalRecordTutorial
//
//  Created by Jovan Jovanovski on 11/3/14.
//  Copyright (c) 2014 SwiftPresenters. All rights reserved.
//

@objc(DetailEntity)
class DetailEntity: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var containerEntity: ContainerEntity

}