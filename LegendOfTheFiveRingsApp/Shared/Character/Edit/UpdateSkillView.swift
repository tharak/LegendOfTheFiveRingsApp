//
//  UpdateSkillView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 16/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct UpdateSkillView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @EnvironmentObject var book: Book
    @ObservedObject var character: Character
    @State var showBuySkill = false

    var body: some View {
        Form {
            ForEach(character.skills(), id:\.self) { skill in
                if let s = book.skills.first(where: {skill.name.contains($0.name)}),
                let traitName = TraitName(rawValue: s.trait.lowercased()) {
                    Stepper("\(skill.name.capitalized) \(character.skillRank(name: skill.name))",
                        onIncrement: {
                            model.buySkill(type: Item.ItemType.skills, name: skill.name, for: character)
                        }, onDecrement: {
                            model.sellSkill(skillName: skill.name, for: character)
                        }
                    )
                    .foregroundColor(RingName.allCases.first(where: {$0.traits.contains(traitName)})?.color ?? Color.accentColor)
                }
            }
        }
        .navigationTitle("Traits")
        .navigationBarItems(trailing: Button(action: {
            showBuySkill.toggle()
        }) {
            Label("Buy Skill", systemImage: "plus.circle")
                .labelStyle(IconOnlyLabelStyle())
                .font(.body)
        })
        .sheet(isPresented: $showBuySkill, content: {
            BuySkillView(character: character, showing: $showBuySkill)
        })

    }
}

//struct UpdateSkillView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateSkillView()
//    }
//}
