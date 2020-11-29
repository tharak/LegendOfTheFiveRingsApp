//
//  CharacterList.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterList: View {
    @Binding var selection: Tab
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Character.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Character>

    var coreDataService: CoreDataService
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(items, id: \.id) { (item: Character) in
//                    NavigationLink(destination: CharacterView(character: item)) {
                        Text(item.name)
//                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Characters \(items.count)")
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                        #if os(iOS)
                        EditButton()
                        #endif
                    }
                )
        }
        .tabItem {
            Label("Characters", systemImage: selection == Tab.characters ? "person.2.fill" : "person.2")
                .accessibility(label: Text("Characters"))
        }
        .tag(Tab.characters)
    }
    
    private func addItem() {
        withAnimation {
            print("add")
            self.coreDataService.createCharacter(name: "wilson \(self.coreDataService.getCharacters()!.count)", xp: 45)
//            self.items.append("asd")
//            print(self.coreDataService.getCharacters())
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            print("delete")
        }
    }
}

//struct CharacterList_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterList(selection:.constant(Tab.characters), coreDataService: CoreDataService())
//    }
//}
