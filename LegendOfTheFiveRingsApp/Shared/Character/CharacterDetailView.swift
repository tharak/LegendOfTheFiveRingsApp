//
//  CharacterDetail.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 16/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterDetailView: View {
    @State var character: Character
    @State var editing = false

    var body: some View {
        VStack {
            if editing {
                CharacterEditView(character: character)
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
                    Label(editing ? "Done" : "XP \(character.xp)", systemImage: editing ? "pencil.circle.fill" : "pencil.circle")
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
