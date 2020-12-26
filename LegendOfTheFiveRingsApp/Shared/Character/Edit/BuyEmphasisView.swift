//
//  BuyEmphasisView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 16/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct BuyEmphasisView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @ObservedObject var character: Character

    var skill: Skill

    var body: some View {
        VStack (alignment: HorizontalAlignment.leading){
            ForEach(getEmphasis(), id:\.self) { emphases in
                Button(action: {
                    if skill.type.contains("Macro-skill") {
                        model.buySkill(type: Item.ItemType.skills, name: "\(skill.name): \(emphases)", for: character)
                    } else {
                        model.buyEmphasis(skillName: skill.name, emphasisName: emphases, for: character)
                    }
                }) {
                    HStack {
                        Text(emphases)
                        Spacer()
                        Image(systemName: "plus.square")
                    }
                    .font(.body)

                }
                .buttonStyle(PlainButtonStyle())
                .frame(minWidth: 44)
                .padding(.horizontal)
                .disabled((!skill.type.contains("Macro-skill") && character.skillRank(name: skill.name) == 0) || hasEmphases(emphases: emphases))
            }
        }
        .font(.body)
    }
    
    func hasEmphases(emphases: String) -> Bool {
        if skill.type.contains("Macro-skill") {
            return character.skillRank(name: "\(skill.name): \(emphases)") != 0
        } else {
            return character.emphases(for: skill.name).contains(where: {$0.name == emphases})
        }
    }
    
    func getEmphasis() -> [String] {
        if skill.type.contains("Macro-skill"), let subskillsNames = getText(original: skill.type, from: "[", to: "]") {
            return subskillsNames.compactMap { (skillTrait) -> String? in
                let skillAndTrait = skillTrait.split(separator: "(")
                if let subskillName = skillAndTrait.first {
                    return "\(subskillName)".trimmingCharacters(in: .whitespacesAndNewlines)
                } else {
                    return nil
                }
            }
        }
        if skill.emphasis.isEmpty || skill.emphasis.lowercased() == "none"{
            return []
        }
        return skill.emphasis.split(separator: ",").compactMap({"\($0)".trimmingCharacters(in: .whitespacesAndNewlines)})
    }
    
    func getText(original: String, from: String, to: String) -> [String]? {
        if original.contains(from) {
            let split = original.split { (char) -> Bool in
                return [from, to].contains(String(char))
            }
            return String(split[1]).split(separator: ",").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)})
        }
        return nil
    }
}

//struct BuyEmphasisView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuyEmphasisView()
//    }
//}
