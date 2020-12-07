//
//  CharacterView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterCreationView: View {

    @Binding var showing: Bool
    let book = Book()
    @ObservedObject var model: LegendOfTheFiveRingsModel

    @State var xp: Int = 45
    @State var name: String = ""
    @State var clan: ClanName = ClanName.crab
    @State var family: Family?
    @State var school: School?

    @State var stamina: Int = 2
    @State var willpower: Int = 2
    @State var strength: Int = 2
    @State var perception: Int = 2
    @State var reflexes: Int = 2
    @State var awareness: Int = 2
    @State var agility: Int = 2
    @State var intelligence: Int = 2
    @State var void: Int = 2
    
    let saveButton: Button<Label<Text, Image>> = Button(action: {
        
    }) {
        Label("Save", systemImage: "plus")
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper(value: $xp) {
                        Text("initial xp:") + Text("\(xp)")
                    }
                    HStack {
                        Text("name:")
                        TextField("name", text: $name)
                    }
                    Picker("clan:", selection: $clan) {
                        ForEach(ClanName.allCases, id: \.self.rawValue) { (clanName: ClanName) in
                            Text(clanName.rawValue.capitalized).tag(clanName)
                        }
                    }
                    Picker("family:", selection: $family) {
                        ForEach(book.families.filter({$0.clan.lowercased() == clan.rawValue}), id: \.self) { (family: Family) in
                            Text(family.name + " " + family.benefit).tag(family as Family?)
                        }
                    }
                    Picker("school:", selection: $school) {
                        ForEach(book.schools.filter({$0.clan.lowercased() == clan.rawValue}), id: \.name) { (school: School) in
                            Text(school.name + " " + (school.benefit ?? "")).tag(school as School?)
                        }
                    }
                }
                Section(header: Text("Rings")) {
                    VStack {
                        VStack {
                            Text(RingName.air.rawValue.capitalized)
                            Stepper(value: $reflexes) {
                                HStack {
                                    Text(TraitName.reflexes.rawValue.capitalized)
                                    Text("\(reflexes)")
                                }
                            }
                            Stepper(value: $awareness) {
                                HStack {
                                    Text(TraitName.awareness.rawValue.capitalized)
                                    Text("\(awareness)")
                                }
                            }
                            Divider()
                        }
                        VStack {
                            Text(RingName.earth.rawValue.capitalized)
                            Stepper(value: $stamina) {
                                Text(TraitName.stamina.rawValue.capitalized)
                                Text("\(stamina)")
                            }
                            Stepper(value: $willpower) {
                                Text(TraitName.willpower.rawValue.capitalized)
                                Text("\(willpower)")
                            }
                            Divider()
                        }
                        VStack {
                            Text(RingName.water.rawValue.capitalized)
                            Stepper(value: $strength) {
                                Text(TraitName.strength.rawValue.capitalized)
                                Text("\(strength)")
                            }
                            Stepper(value: $perception) {
                                Text(TraitName.perception.rawValue.capitalized)
                                Text("\(perception)")
                            }
                            Divider()
                        }
                        VStack {
                            Text(RingName.fire.rawValue.capitalized)
                            Stepper(value: $agility) {
                                Text(TraitName.agility.rawValue.capitalized)
                                Text("\(agility)")
                            }
                            Stepper(value: $intelligence) {
                                Text(TraitName.intelligence.rawValue.capitalized)
                                Text("\(intelligence)")
                            }
                            Divider()
                        }
                        VStack {
                            Text(RingName.void.rawValue.capitalized)
                            Stepper(value: $void) {
                                Text(RingName.void.rawValue.capitalized)
                                Text("\(void)")
                            }

                        }
                    }
                    .font(.subheadline)
//                        Picker(clanName.rawValue, selection: $school) {
//                            ForEach(book.schools.filter({$0.clan.lowercased() == clan.rawValue}), id: \.name) { (school: School) in
//                                Text(school.name)
//                            }
//                        }.pickerStyle(SegmentedPickerStyle())
                    
                }

            }
            .navigationBarTitle(Text("New Character"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.showing.toggle()
            }) {
                Label("Cancel", systemImage: "minus")
            }, trailing: saveButton)
        }
    }
}

//struct CharacterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterView(character: Character()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
