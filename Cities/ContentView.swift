//
//  ContentView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            Text("Hello, World!")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
