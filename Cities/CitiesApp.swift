//
//  CitiesApp.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI

@main
struct CitiesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CitiesMainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
