//
//  CoreDataManagedContext.swift
//  GymApp
//
//  Created by Chris on 2020/7/15.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManagedContext {
    
    let managedObjectContext: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "GymApp")
        container.loadPersistentStores { (desc, err) in
            if let err = err {
                fatalError("core data error: \(err)")
            }
        }
        let context = container.viewContext
        
        return context
    }()
    
    static let sharedInstance = CoreDataManagedContext()
    
    private init() {}
    
}
