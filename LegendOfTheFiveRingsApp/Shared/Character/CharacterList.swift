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
    @State var showCharacterCreation = true
    @ObservedObject var model = LegendOfTheFiveRingsModel()

    var body: some View {
        NavigationView {
            Form {
                ForEach(model.characters, id: \.id) { (item: Character) in
                    NavigationLink(destination: Text("\(item.name)")) {
                        Text(item.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Characters \(model.characters.count)")
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            showCharacterCreation.toggle()
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }.sheet(isPresented: $showCharacterCreation) {
                            CharacterCreationView(showing: self.$showCharacterCreation, model: model)
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
