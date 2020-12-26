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
    var traitName: TraitName

    var body: some View {
        HStack {
            HStack {
                ForEach(character.emphases(for: skill.name), id:\.self) { emphases in
                    VStack {
                        Text("\(skill.name) (\(emphases.name))")
                        DieView(roll: .constant(character.trait(name: traitName) + character.skillRank(name: skill.name)), keep: .constant(character.trait(name: traitName)), bonus: .constant(0), keepHigh: .constant(true), explodesOn: .constant(10), rerollOnOne: .constant(true), color: .constant(traitName.color))
                    }
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(traitName.color, lineWidth: 2))
                    .foregroundColor(traitName.color)
                }
            }
            VStack {
                HStack (spacing: 0){
                    if skill.type == "\(Item.ItemType.schoolSkill)" {
                        Image(systemName: "graduationcap.fill")
                            .scaleEffect(0.75)
                    }
                    Text("\(skill.name) \(character.skillRank(name: skill.name))")
                }
                DieView(roll: .constant(character.trait(name: traitName) + character.skillRank(name: skill.name)), keep: .constant(character.trait(name: traitName)), bonus: .constant(0), keepHigh: .constant(true), explodesOn: .constant(10), rerollOnOne: .constant(false), color: .constant(traitName.color))
                
            }
            .padding(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(traitName.color, lineWidth: 2))
            .foregroundColor(traitName.color)
        }

    }
}

//struct SkillView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkillView(skill: Item())
//    }
//}
