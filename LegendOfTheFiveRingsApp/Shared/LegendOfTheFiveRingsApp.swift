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
    @State private var selection: Tab = .characters
    
    var coreDataService: CoreDataService
    var coreDataStack: CoreDataStack

    init() {
        coreDataStack = CoreDataStack()
        coreDataService = CoreDataService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    var body: some Scene {
        WindowGroup {
            TabView (selection: $selection) {
                CharacterList(selection: $selection, coreDataService: coreDataService)
                    .environment(\.managedObjectContext, coreDataStack.mainContext)
                Text("Dice")
                    .tabItem {
                        Label("Dice", systemImage: selection == Tab.dice ? "hexagon.fill" : "hexagon")
                            .accessibility(label: Text("Dice"))
                    }
                    .tag(Tab.dice)
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
}
