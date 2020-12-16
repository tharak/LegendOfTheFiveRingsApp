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
                        if woundLevel() != nil {
                            if woundLevel() != .out {
                                Text("Penalty: +\(woundPenalty(woundLevel: woundLevel()))")
                            }
                            if woundLevel() == .down {
                                Text("Must spend void to act")
                            }
                            if woundLevel() == .out {
                                Text("Cannot Act")
                            }
                        }
                    }
                    .font(.footnote)
                }
                Spacer()
                Text("\(woundLevel()?.rawValue.capitalized ?? "💀")")
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
        let percent = CGFloat(damage) / CGFloat(character.ring(name: .earth) * 19)
        return Color(red: Double(percent), green: Double(1 - percent), blue: 0)
    }

    public func woundLevel() -> WoundLevel? {
        let earth = character.ring(name: .earth)
        switch damage {
        case ...(earth * 5):
            return .healthy
        case ...(earth * 7):
            return .nicked
        case ...(earth * 9):
            return .grazed
        case ...(earth * 11):
            return .hurt
        case ...(earth * 13):
            return .injured
        case ...(earth * 15):
            return .crippled
        case ...(earth * 17):
            return .down
        case ...(earth * 19):
            return .out
        default:
            return nil
        }
    }

    public func woundPenalty(woundLevel: WoundLevel?) -> Int {
        guard let woundLevel = woundLevel else {
            return 0
        }
        switch woundLevel {
        case .healthy:
            return 0
        case .nicked:
            return 3
        case .grazed:
            return 5
        case .hurt:
            return 10
        case .injured:
            return 15
        case .crippled:
            return 20
        case .down:
            return 40
        case .out:
            return 0
        }
    }
}

//struct WoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        WoundView(earth: 2)
//    }
//}
