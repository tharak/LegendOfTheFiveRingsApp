//
//  CharacterDetail.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 16/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterDetailView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @State var character: Character
    @State var editing = true

    var body: some View {
        VStack {
            if editing {
                if let first = model.characters.first {
                    CharacterEditView(character: first)
                } else {
                    CharacterEditView(character: character)
                }
            } else {
                CharacterView(character: character)
            }
        }
        .navigationBarTitle(Text(character.name), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    editing.toggle()
                }) {
                    Label(editing ? "Done" : "Edit", systemImage: editing ? "pencil.circle.fill" : "pencil.circle")
                        .labelStyle(IconOnlyLabelStyle())
                        .font(.title)
                }
            }
        )
    }
}

//struct CharacterDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterDetail()
//    }
//}
