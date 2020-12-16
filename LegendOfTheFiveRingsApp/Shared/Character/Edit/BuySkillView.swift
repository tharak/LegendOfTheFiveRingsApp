//
//  BuySkillView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 16/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct BuySkillView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @EnvironmentObject var book: Book

    @ObservedObject var character: Character

    @Binding var showing: Bool
    @State var category: String = LegendOfTheFiveRings.Category.high.rawValue
    @State private var showingAlert = false
    @State private var skillName = ""
    @State private var skillDescription = ""

    var body: some View {
        NavigationView {
            Form {
                ForEach(book.skills.filter({category.contains($0.category.rawValue)}), id:\.self) { (skill: Skill)in
                    VStack (alignment: HorizontalAlignment.leading, spacing: 4) {
                        HStack (spacing: 8) {
                            Text(skill.name)
                                .font(.headline)
                            Text("(\(skill.trait))")
                                .font(.subheadline)
                            Spacer()
                            Button(action: {
                                skillName = skill.name
                                skillDescription = skill.description
                                showingAlert.toggle()
                            }) {
                                Label("Description", systemImage: "info.circle")
                                    .labelStyle(IconOnlyLabelStyle())
                                    .font(.body)
                            }
                            .buttonStyle(PlainButtonStyle())
                            if !skill.type.contains("Macro-skill") {
                                Spacer()
                                Button(action: {
                                    model.buySkill(type: Item.ItemType.skills, name: skill.name, for: character)
                                }) {
                                    Label("Buy", systemImage: "plus.rectangle")
                                        .labelStyle(IconOnlyLabelStyle())
                                        .font(.body)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(character.skillRank(name: skill.name) != 0)
                            }
                        }
                        .foregroundColor(RingName.allCases.first(where: {$0.traits.contains(TraitName(rawValue: skill.trait.lowercased()) ?? TraitName.agility)})?.color ?? Color.accentColor)
                        BuyEmphasisView(character: character, skill: skill)
                            .foregroundColor(RingName.allCases.first(where: {$0.traits.contains(TraitName(rawValue: skill.trait.lowercased()) ?? TraitName.agility)})?.color ?? Color.accentColor)
                        if skill.mastery != "None" {
                            Text(skill.mastery)
                                .font(.footnote)
                        }
                    }    
                }
            }
            .navigationBarItems(trailing:
                HStack {
                    Picker("Category", selection: $category) {
                        ForEach(["High", "Bugei", "Low", "Merchant"], id: \.self) { index in
                            Text(index).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Button(action: {
                        showing.toggle()
                    }) {
                        Label("Done", systemImage: "info.circle")
                            .labelStyle(TitleOnlyLabelStyle())
                    }
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(skillName), message: Text(skillDescription))
            }
        }
    }
}

//struct BuySkillView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuySkillView(showing: .constant(true))
//    }
//}
