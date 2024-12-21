//
//  MyDayApp.swift
//  MyDay
//
//  Created by Gerasimov's on 2024-03-04.
//

import SwiftUI

@main
struct MyDayApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
