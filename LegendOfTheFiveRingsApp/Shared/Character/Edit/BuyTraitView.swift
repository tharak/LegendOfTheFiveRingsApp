//
//  BuyTraitView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 16/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct BuyTraitView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @ObservedObject var character: Character

    var body: some View {
        Form {
            ForEach(RingName.allCases, id:\.self) { ringName in
                Text("\(ringName.rawValue.capitalized) \(character.ring(name: ringName))")
                    .foregroundColor(ringName.color)
                    .font(.headline)
                ForEach(ringName.traits, id:\.self) { traitName in
                    Stepper("\(traitName.rawValue.capitalized) \(character.trait(name: traitName))",
                        onIncrement: {
                            model.buyTrait(type: .traits, name: traitName, for: character)
                        }, onDecrement: {
                            model.sellTrait(name: traitName, for: character)
                        }
                    )
                }
                .foregroundColor(ringName.color)
                .font(.subheadline)
            }
        }.navigationTitle("Traits")
    }
}

//struct BuyTraitView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuyTraitView()
//    }
//}
