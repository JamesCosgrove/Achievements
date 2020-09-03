//
//  AchievementsApp.swift
//  Achievements
//
//  Created by James Cosgrove on 03/09/2020.
//

import SwiftUI

@main
struct AchievementsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
