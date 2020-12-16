//
//  InitiativeView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 14/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct InitiativeView: View {

    @State var rank: Int
    @State var trait: Int
    @State var bonus: Int = 0

    var body: some View {
        HStack{
            Text("Initiative:")
                .font(.body)
            DieView(roll: .constant(rank + trait), keep: $trait, bonus: $bonus, keepHigh: .constant(true), explodesOn: .constant(10), rerollOnOne: .constant(false), color: .constant(RingName.air.color))
            Spacer()
            Stepper("Bonus", value: $bonus)
                .font(.subheadline)
                .labelsHidden()
        }
        .padding(.horizontal, -8)
    }
}
