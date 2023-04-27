//
//  CapstoneIosFinalApp.swift
//  CapstoneIosFinal
//
//  Created by Glendon Philipp Baculio on 4/28/23.
//

import SwiftUI

@main
struct CapstoneIosFinalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
