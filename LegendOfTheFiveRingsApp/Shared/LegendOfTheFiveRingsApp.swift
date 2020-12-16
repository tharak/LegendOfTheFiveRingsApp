//
//  LegendOfTheFiveRingsAppApp.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings
import LegendOfTheFiveRingsRoller

@main
struct LegendOfTheFiveRingsApp: App {
    
    @State private var selection: Tab = .testChar
    var body: some Scene {
        WindowGroup {
            TabView (selection: $selection) {
                CharacterView()
                CharacterList(selection: $selection)
                DiceView(selection: $selection)
                BookView(selection: $selection)
                HistoryView(selection: $selection)
            }
            .environmentObject(LegendOfTheFiveRingsModel())
            .environmentObject(LegendOfTheFiveRingsRollerModel())
            .environmentObject(Book())
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

// MARK: - Tab
enum Tab {
    case testChar
    case characters
    case dice
    case book
    case history
}
