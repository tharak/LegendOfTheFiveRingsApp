//
//  DieView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 10/12/20.
//

import SwiftUI
import LegendOfTheFiveRingsRoller

struct DieView: View {
    @EnvironmentObject var roller: LegendOfTheFiveRingsRollerModel
    
    @Binding var roll: Int
    @Binding var keep: Int
    @Binding var bonus: Int
    @Binding var keepHigh: Bool
    @Binding var explodesOn: Int?
    @Binding var rerollOnOne: Bool
    @Binding var color: Color?

    @State var result: RollResult? = nil
    
    var body: some View {
        Button {
            withAnimation {
                self.result = self.roller.roll(amount: roll, keep: keep, bonus: bonus,
                                keepHigh: keepHigh,
                                explodesOn: explodesOn,
                                rerollOnOne: rerollOnOne)
            }
        } label: {
            if let result = result {
                Label("\(roll)k\(keep)\(bonusText()) = \(result.total)", systemImage: "die.face.5")
                    .font(Font.headline)
            } else {
                Label("\(roll)k\(keep)\(bonusText())", systemImage: "die.face.5")
                    .font(Font.headline)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(4)
        .foregroundColor(color ?? Color.accentColor)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(color ?? Color.accentColor, lineWidth: 2))
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
        DieView(roll: .constant(1), keep: .constant(1), bonus: .constant(0), keepHigh: .constant(true), explodesOn: .constant(10), rerollOnOne: .constant(false), color: .constant(Color.accentColor))
            .environmentObject(LegendOfTheFiveRingsRollerModel())
    }
}
