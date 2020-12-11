//
//  DieView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 10/12/20.
//

import SwiftUI
import LegendOfTheFiveRingsRoller

struct DieView: View {
    @ObservedObject var model: LegendOfTheFiveRingsRollerModel
    
    @Binding var roll: Int
    @Binding var keep: Int
    @Binding var bonus: Int
    @Binding var keepHigh: Bool
    @Binding var explodesOn: Int?
    @Binding var rerollOnOne: Bool
    @Binding var color: Color

    var body: some View {
        Button {
            withAnimation {
                self.model.roll(amount: roll, keep: keep, bonus: bonus,
                                keepHigh: keepHigh,
                                explodesOn: explodesOn,
                                rerollOnOne: rerollOnOne)
            }
        } label: {
            Label("\(roll)k\(keep)\(bonusText())", systemImage: "die.face.5")
                .font(Font.headline)
        }
        .padding(4)
        .foregroundColor(color)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(color, lineWidth: 2))
    }
    
    func bonusText() -> String {
        if bonus > 0 {
            return " + \(bonus)"
        }
        if bonus < 0 {
            return " - \(bonus+(bonus*(-2)))"
        }
        return ""
    }
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        DieView(model: LegendOfTheFiveRingsRollerModel(), roll: .constant(1), keep: .constant(1), bonus: .constant(0), keepHigh: .constant(true), explodesOn: .constant(10), rerollOnOne: .constant(false), color: .constant(Color.accentColor))
    }
}
