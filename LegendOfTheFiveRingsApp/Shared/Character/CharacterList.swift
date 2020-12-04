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
    
    @ObservedObject var model = LegendOfTheFiveRingsModel()
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(model.characters, id: \.id) { (item: Character) in
                    NavigationLink(destination: CharacterView(character: item)) {
                        Text(item.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Characters \(model.characters.count)")
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
            self.model.create(name: "Wilson \(model.characters.count)", xp: 45)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for i in offsets {
                self.model.delete(character: self.model.characters[i])
            }
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList(selection:.constant(Tab.characters))
    }
}
