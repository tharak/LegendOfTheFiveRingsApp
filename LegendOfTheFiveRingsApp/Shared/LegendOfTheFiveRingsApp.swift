//
//  LegendOfTheFiveRingsAppApp.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

@main
struct LegendOfTheFiveRingsApp: App {
    
    let persistenceController = PersistenceController.shared
    @State private var selection: Tab = .dice

    var body: some Scene {
        WindowGroup {
            TabView (selection: $selection) {
                CharacterList(selection: $selection)
                DiceView(selection: $selection)
                FrameworkTestView(selection: $selection)
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

// MARK: - Tab
enum Tab {
    case characters
    case dice
    case book
    case content
}
