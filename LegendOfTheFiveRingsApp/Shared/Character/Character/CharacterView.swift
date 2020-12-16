//
//  CharacterView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 09/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterView: View {
    @EnvironmentObject var book: Book
    @State var character: Character

    var body: some View {
        Form {
            Section {
                CharacterCell(character: character)
                HStack {
                    Spacer()
                    VStack {
                        Text("Honor")
                        Text("\(Double(character.honor)/10, specifier: "%.1f")")
                    }
                    Divider()
                    VStack {
                        Text("Glory")
                        Text("\(character.glory)")
                    }
                    Divider()
                    VStack {
                        Text("Status")
                        Text("\(character.status)")
                    }
                    Divider()
                    VStack {
                        Text("Taint")
                        Text("\(character.shadowlandsTaint)")
                    }
                    Spacer()
                }
            }
            Section {
                VStack {
                    HStack {
                        RingView(ring: RingName.earth, character: character)
                        Divider()
                        RingView(ring: RingName.air, character: character)
                    }
                    HStack {
                        RingView(ring: RingName.water, character: character)
                        Divider()
                        RingView(ring: RingName.fire, character: character)
                    }
                    RingView(ring: RingName.void, character: character)
                }
            }
            Section {
                InitiativeView(rank: character.rank(), trait: character.trait(name: .reflexes))
                ArmorView(reflexes: character.trait(name: .reflexes))
                WoundView(character: character)
            }
            Section(header: Text("Skills:")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(character.skills(), id:\.self) { skill in
                            if let s = book.skills.first(where: {skill.name.contains($0.name)}),
                               let traitName = TraitName(rawValue: s.trait.lowercased()) {
                                SkillView(skill: skill, character: character, traitName: traitName)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                }
                .padding(.horizontal, -20)
            }
        }
    }
}

//struct CharacterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterView()
//            .environmentObject(LegendOfTheFiveRingsModel())
//            .environmentObject(Book())
//    }
//}
