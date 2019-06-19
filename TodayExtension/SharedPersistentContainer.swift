//
//  SharedPersistentContainer.swift
//  TodayExtension
//
//  Created by Рыжков Артем on 19.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import Foundation
import CoreData

class SharedPersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.onl1steam.TaskTracker")
        storeURL = storeURL?.appendingPathComponent("TaskTracker.sqlite")
        return storeURL!
    }
    
    
    
}
