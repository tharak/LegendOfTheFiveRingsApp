//
//  ArmorView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 14/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct ArmorView: View {
    @EnvironmentObject var book: Book
    @State var character: Character
    @State var seletedArmor: Int = 0
    @State var tn: Int = 0

    var armorNames: [String] {
        var armors = character.armors().map({String($0.name.split(separator: " ").first ?? "")})
        armors.insert("None", at: 0)
        return armors
    }

    var body: some View {
        VStack {
            Label("TN: \(totalArmor())", systemImage: "shield.fill")
                .font(.headline)
            Picker("armor:", selection: $seletedArmor) {
                ForEach(0..<armorNames.count, id: \.self) { index in
                    Text(armorNames[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, -16)
            HStack {
                if seletedArmor == 0 {
                    Text("TN: 0")
                    Text("Reduction: 0")
                } else {
                    let armor = book.armors[seletedArmor - 1]
                    if armor.tn.count == 2 {
                        HStack {
                            Text("TN: ")
                            Picker("TN:", selection: $tn) {
                                ForEach(armor.tn, id: \.self) { (value: Int) in
                                    Text("\(value)").tag(value)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    } else {
                        Text("TN: \(armor.tn.first ?? 0)")
                    }
                    Text("Reduction: \(armor.reduction)")
                }
            }
            .font(.footnote)
            if seletedArmor > 0, let special = book.armors[seletedArmor - 1].special {
                Text(special)
                    .font(.footnote)
            }
        }
    }
    
    func totalArmor() -> Int {
        if seletedArmor == 0 {
            return 5 + (character.trait(name: TraitName.reflexes) * 5)
        }
        if seletedArmor == book.armors.count {
            return 5 + (character.trait(name: TraitName.reflexes) * 5) + tn
        }
        return 5 + (character.trait(name: TraitName.reflexes) * 5) + (book.armors[seletedArmor - 1].tn.first ?? 0)
    }
}
