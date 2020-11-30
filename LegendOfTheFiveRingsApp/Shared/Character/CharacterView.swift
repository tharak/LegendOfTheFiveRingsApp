//
//  CharacterView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterView: View {
    
    @State var character: Character

    @State var newName: String = ""
    
    var body: some View {
        List {
            Text("character")
            TextField(character.name, text: $newName)
            HStack {
                Text("Xp:")
                Text("\(character.xp)")
            }
            
//            ForEach(character.items.sorted(by: {$0 > $1})) { (item: Item) in
//                Text(item.name)
//            }
        }
        .navigationTitle(character.name)
        .navigationBarItems(trailing:
            Button(action: {
                if !newName.isEmpty {
    //                                        self.character.name = newName
                }
            }) {
                Label("Save", systemImage: "plus")
            }
        )
    }
}

//struct CharacterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterView(character: Character()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

