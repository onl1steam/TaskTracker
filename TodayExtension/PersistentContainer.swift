//
//  SharedPersistentContainer.swift
//  TodayExtension
//
//  Created by Рыжков Артем on 19.06.2019.
//  Copyright © 2019 Рыжков Артем. All rights reserved.
//

import Foundation
import CoreData

class PersistentContainer: NSPersistentContainer {
    override class func defaultDirectoryURL() -> URL{
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.onl1steam.TaskTracker")!
    }
    
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
    }
    
}
