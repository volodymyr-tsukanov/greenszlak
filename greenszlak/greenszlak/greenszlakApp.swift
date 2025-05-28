//
//  greenszlakApp.swift
//  greenszlak
//
//  Created by student on 28/05/2025.
//

import SwiftUI

@main
struct greenszlakApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
