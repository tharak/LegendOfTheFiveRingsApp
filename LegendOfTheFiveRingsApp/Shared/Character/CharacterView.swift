//
//  CharacterView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 09/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterView: View {

    @ObservedObject var model: LegendOfTheFiveRingsModel
    @State var character: Character
    @State var name: String = ""
    
    var body: some View {
            Form {
                Section {
                    HStack {
                        Text(character.name)
                        Spacer()
                        Divider()
                        Text("XP: \(character.xp)")
                    }
                    HStack {
                        Text(ClanName.emoji(name: character.clan()?.name))
                            .font(.largeTitle)
                        Divider()
                        Text(character.family()?.name ?? "")
                        Divider()
                        ForEach(character.schools(), id:\.self) { school in
                            Text(school.name)
                        }
                        Spacer()
                    }
                }
                Section {
                    HStack {
                        Text("XP")
                        Spacer()
                        Text("unexpent:")
                        Text("\(character.xp)")
                        Divider()
                        Text("expended:")
                        Text("\(character.items.reduce(0, {$0 + ($1 as! Item).points}))")
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
                Section(header: Text("Skills:")) {
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(character.skills(), id:\.self) { skill in
                                SkillView(skill: skill, character: character, traitValue: 0, hasEmphasis: false)
                            }
                        }
                    }
                }
            }
            .onAppear() {
                self.name = character.name
            }
            .navigationBarTitle(Text(character.name), displayMode: .inline)
            .tabItem {
                Label("Characters", systemImage: "person.fill")
                    .accessibility(label: Text("Characters"))
            }
            .tag(Tab.testChar)
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(model: LegendOfTheFiveRingsModel(), character: LegendOfTheFiveRingsModel().characters.first!)
    }
}
