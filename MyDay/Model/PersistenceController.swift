//
//  PersistenceController.swift
//  MyDay
//
//  Created by Maryna Bosko on 2025-01-14.
//

import CoreData

struct PersistenceController{
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init (inMemory: Bool = false){
        
        container = NSPersistentContainer(name: "MyDayDataModel")
        
        if inMemory{
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("\(error), \(error.userInfo)")
            }
            
        }
        
    }
    
}
