//
//  SkillView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 10/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct SkillView: View {
    
    let skill: Item
    @State var character: Character
    let book = Book()
    
    var body: some View {
        VStack {
            HStack{
                Text(skill.name)
                Text("\(character.skillRank(name: skill.name))")
            }
            Text("1k1")
        }
    }
}

//struct SkillView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkillView(skill: Item())
//    }
//}
