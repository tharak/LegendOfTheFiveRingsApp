//
//  CharacterEditView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 16/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterEditView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @EnvironmentObject var book: Book

    @ObservedObject var character: Character

    @State var showBuySkill = false
    @State var seletedArmor: Int = 0
    var body: some View {
        Form {
            Section {
                CharacterCell(character: character)
                VStack {
                    Stepper("XP \(character.xp)", value: $character.xp)
                    Stepper("Honor \(Double(character.honor)/10, specifier: "%.1f")", value: $character.honor)
                    Stepper("Glory \(Double(character.glory)/10, specifier: "%.1f")", value: $character.glory)
                    Stepper("Status \(Double(character.status)/10, specifier: "%.1f")", value: $character.status)
                    Stepper("Taint \(Double(character.shadowlandsTaint)/10, specifier: "%.1f")", value: $character.shadowlandsTaint)
                }
            }
            Section(header: Text("Traits:")) {
                ForEach(RingName.allCases, id:\.self) { ringName in
                    HStack {
                        ForEach(ringName.traits, id:\.self) { traitName in
                            Stepper("\(traitName.rawValue.capitalized) \(character.trait(name: traitName))",
                                onIncrement: {
                                    model.buyTrait(type: .traits, name: traitName, for: character)
                                }, onDecrement: {
                                    model.sellTrait(name: traitName, for: character)
                                }
                            )
                        }
                    }
                    .foregroundColor(ringName.color)
                    .font(.subheadline)
                }
            }
            Section(header: HStack {
                Text("Skills:")
                Spacer()
                Button(action: {
                    showBuySkill.toggle()
                }) {
                    Label("Buy Skill", systemImage: "plus.circle")
                        .labelStyle(IconOnlyLabelStyle())
                        .font(.body)
                }
            }) {
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
        }
        .sheet(isPresented: $showBuySkill, content: {
            BuySkillView(character: character, showing: $showBuySkill)
        })
        .tag(Tab.testChar)
    }
}

//struct CharacterEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterEditView()
//    }
//}
