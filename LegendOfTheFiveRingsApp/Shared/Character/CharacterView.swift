//
//  CharacterView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI

struct CharacterView: View {
    
    @State var character: Character

    @State var newName: String = ""
    
    var body: some View {
        List {
            TextField(character.name!, text: $newName)
            HStack {
                Text("Xp:")
                Text("\(character.expendedXp)")
            }
            ForEach(character.itemsOrder, id: \.self) { type in
                Section (header: Text(type.rawValue.capitalized)) {
                    ForEach(character.itemsFiltered(by: type), id: \.self) { item in
                        HStack {
                            Text(item.name!)
                            Text("\(item.points)")
                            Text(item.type!)
                        }
                    }

                }
            }
        }
        .navigationTitle(character.name!)
        .navigationBarItems(trailing:
                                Button(action: {
                                    if !newName.isEmpty {
                                        self.character.name = newName
                                    }
                                }) {
                Label("Save", systemImage: "plus")
            }
        )
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension Character {
    
    var expendedXp: Int16 {
        if let items = self.items as? Set<Item> {
            let total = items.map({$0.points}).reduce(0) { $0 + $1 }
            return xp - total
        }
        return xp
    }
    
    var itemsOrder: [ItemType] {
        return [.info, .clan, .families, .schools, .attributes, .status, .weapons, .armors, .skills, .spells, .tattoos, .katas, .kihos, .advantages, .disadvantages, .ancestors]
    }
    
    func itemsFiltered(by type: ItemType) -> [Item] {
        if let items = self.items as? Set<Item> {
            return items.filter({$0.type == type.rawValue}).sorted()
        }
        return []
    }
    
    func buy(itemType: ItemType, name: String, points: Int) {
        
    }
}

extension Item: Comparable {
    public static func < (lhs: Item, rhs: Item) -> Bool {
        lhs.timestamp! < rhs.timestamp!
    }
}

enum ItemType: String {
    case advantages, ancestors, armors, clan, disadvantages, families, katas, kihos, schools, shadowlandsPowers, skills,  spells, tattoos, weapons
    case info //player name xp
    case status // honor, glory, status, shadowlands taint
    case attributes
}

enum ItemSubtypes: String {
    case stamina, willpower, strength, perception, reflexes, awareness, agility, intelligence, void
}
