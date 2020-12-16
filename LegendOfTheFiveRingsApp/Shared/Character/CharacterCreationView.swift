//
//  CharacterView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterCreationView: View {

    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @EnvironmentObject var book: Book

    @Binding var showing: Bool
    @State var xp: Int = 45
    @State var name: String = ""
    @State var clan: ClanName = ClanName.crab
    @State var family: Family?
    @State var school: School?

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper(value: $xp) {
                        Text("initial xp: ") + Text("\(xp)")
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
            }
            .navigationBarTitle(Text("New Character"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.showing.toggle()
            }) {
                Text("cancel")
            }, trailing:
                Button(action: {
                    guard let family = family, let school = school else {
                        return
                    }
                    self.model.create(name: name, xp: xp, clan: clan, family: family, school: school)
                    self.showing.toggle()
                }) {
                    Text("Save")
                }
            )
        }
    }
}

struct CharacterCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCreationView(showing: .constant(true))
    }
}
