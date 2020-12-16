//
//  CharacterCell.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 12/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterCell: View {
    
    @State var character: Character

    var body: some View {
        HStack {
            Text(ClanName.emoji(name: character.clan()?.name))
                .font(.title)
            Divider()
            Text(character.family()?.name ?? "")
            Text(character.name)
            Divider()
            ForEach(character.schools(), id:\.self) { school in
                Text(school.name)
            }
            Text("\(character.rank())")
        }
    }
}

//struct CharacterCell_Previews: PreviewProvider {
//    static var previews: some View {
////        CharacterCell(character: <#T##Character#>)
//    }
//}
