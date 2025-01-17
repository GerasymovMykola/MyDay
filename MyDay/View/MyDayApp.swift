//
//  MyDayApp.swift
//  MyDay
//
//  Created by Gerasimov's on 2024-03-04.
//

import SwiftUI

@main
struct MyDayApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(context: persistenceController.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
