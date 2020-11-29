//
//  CharacterView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI

struct CharacterView: View {
    
//    @State var character: Character

    @State var newName: String = ""
    
    var body: some View {
        List {
            Text("character")
//            TextField(character.name!, text: $newName)
//            HStack {
//                Text("Xp:")
//                Text("\(character.expendedXp)")
//            }
//            ForEach(character.itemsOrder, id: \.self) { type in
//                Section (header: Text(type.rawValue.capitalized)) {
//                    ForEach(character.itemsFiltered(by: type), id: \.self) { item in
//                        HStack {
//                            Text(item.name!)
//                            Text("\(item.points)")
//                            Text(item.type!)
//                        }
//                    }
//
//                }
//            }
        }
        .navigationTitle("character.name!")
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


extension ItemData: Comparable {
    public static func < (lhs: ItemData, rhs: ItemData) -> Bool {
        lhs.timestamp! < rhs.timestamp!
    }
}
