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
            Section {
                NavigationLink(destination: BuyTraitView(character: character)) {
                    Text("Traits:")
                }
            }
            Section {
                NavigationLink(destination: UpdateSkillView(character: character)) {
                    Text("Skills:")
                }
            }
        }
        .tag(Tab.testChar)
    }
}

//struct CharacterEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterEditView()
//    }
//}
