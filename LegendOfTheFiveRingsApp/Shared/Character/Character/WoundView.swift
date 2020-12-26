//
//  WoundView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 14/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct WoundView: View {
    @State var character: Character

    @State var healthy: Int = 0
    @State var damage: Int = 0
    @State var currentWound = WoundLevel.healthy

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Wounds: \(damage)/\(character.ring(name: .earth) * 19)")
                    VStack {
                        if let woundLevel = character.woundLevel(damage: damage) {
                            if woundLevel != .out {
                                Text("Penalty: +\(character.woundPenalty(woundLevel: woundLevel))")
                            }
                            if woundLevel == .down {
                                Text("Must spend void to act")
                            }
                            if woundLevel == .out {
                                Text("Cannot Act")
                            }
                        }
                    }
                    .font(.footnote)
                }
                Spacer()
                Text("\(character.woundLevel(damage: damage)?.rawValue.capitalized ?? "💀")")
                    .font(.headline)
                    .foregroundColor(woundColor())
                    .padding(4)
                Spacer()
                VStack {
                    Stepper("Wounds: \(damage)/\(character.ring(name: .earth) * 19)", value: $damage)
                        .font(.subheadline)
                        .labelsHidden()
                    Button("Rest (\(character.trait(name: .stamina) * 2 + character.rank()))") {
                        let heal = character.trait(name: .stamina) * 2 + character.rank()
                        damage = max(damage - heal, 0)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    
                }
            }
        }
    }

    public func woundColor() -> Color {
        let percent = Double(damage) / Double(character.ring(name: .earth) * 19)
        return Color(red: percent, green: 1 - percent, blue: 0)
    }
}

//struct WoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        WoundView(earth: 2)
//    }
//}
