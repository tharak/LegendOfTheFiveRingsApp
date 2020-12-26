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
        VStack {
            HStack {
                Text(ClanName.emoji(name: character.clan()?.name))
                    .font(.title)
                Text(character.family()?.name ?? "")
                Text(character.name)
                Spacer()
            }
            HStack {
                ForEach(character.schools(), id:\.self) { school in
                    Text(school.name)
                }
                Text("\(character.rank())")
                Spacer()
            }
            .font(.subheadline)
        }
    }
}
