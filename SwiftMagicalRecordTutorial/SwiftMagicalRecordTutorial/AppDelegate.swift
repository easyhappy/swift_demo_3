//
//  AppDelegate.swift
//  SwiftMagicalRecordTutorial
//
//  Created by Jovan Jovanovski on 11/3/14.
//  Copyright (c) 2014 SwiftPresenters. All rights reserved.
//

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        MagicalRecord.setupCoreDataStack()
        return true
    }

}

