//
//  SkillView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 10/12/20.
//

import SwiftUI
import LegendOfTheFiveRings
import LegendOfTheFiveRingsRoller

struct SkillView: View {
    let skill: Item
    @State var character: Character
    var traitValue: Int
    var hasEmphasis: Bool

    var body: some View {
        VStack {
            HStack{
                Text(skill.name)
                Text("\(character.skillRank(name: skill.name))")
            }
            DieView(roll: .constant(character.skillRank(name: skill.name)), keep: .constant(traitValue + character.skillRank(name: skill.name)), bonus: .constant(0), keepHigh: .constant(true), explodesOn: .constant(10), rerollOnOne: .constant(hasEmphasis), color: .constant(Color.red))
        }
        .background(Color.orange)
    }
}

//struct SkillView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkillView(skill: Item())
//    }
//}
