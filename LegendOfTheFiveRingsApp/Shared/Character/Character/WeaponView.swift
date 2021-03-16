//
//  WeaponView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 27/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct WeaponView: View {
    @EnvironmentObject var book: Book
    @State var character: Character

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(character.weapons(), id:\.self) { weapon in
                    if let skill = skillForWeapon(name: weapon.name),
                       let traitName = (TraitName(rawValue: skill.trait.lowercased()) ?? TraitName.allCases.first(where: {skill.trait.lowercased().contains($0.rawValue)})) {
                        VStack {
                            Text(weapon.name)
                            DieView(roll: .constant(character.trait(name: traitName) + character.skillRank(name: skill.name)), keep: .constant(character.trait(name: traitName)), bonus: .constant(0), keepHigh: .constant(true), explodesOn: .constant(10), rerollOnOne: .constant(character.emphases(for: skill.name).first(where: {$0.name == weapon.name}) != nil), color: .constant(traitName.color))
                        }
                        .padding(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(traitName.color, lineWidth: 2))
                        .foregroundColor(traitName.color)
                    } else {
                        VStack {
                            Text(weapon.name)
                            Text("\(skillForWeapon(name: weapon.name)?.trait ?? "")")
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
        }
        .padding(.horizontal, -20)
    }

    func skillForWeapon(name: String) -> Skill? {
        return book.skills.first(where: {$0.emphasis.contains(name)})
    }
}
