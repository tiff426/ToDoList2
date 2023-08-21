//
//  ToDoList2App.swift
//  ToDoList2
//
//  Created by Scholar on 8/21/23.
//

import SwiftUI

@main
struct ToDoList2App: App {
    
    // this code allows the rest of our prgram to "talk" to Core Data
    let persistenceController = PersistenceController.shared // "shares" core data???
    
    var body: some Scene {
        WindowGroup {
            // added environment midofier to ContentView()
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
