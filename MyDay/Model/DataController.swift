//
//  DataController.swift
//  MyDay
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "MyDayDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Data error: \(error.localizedDescription)")
            }
        }
    }
    
}
