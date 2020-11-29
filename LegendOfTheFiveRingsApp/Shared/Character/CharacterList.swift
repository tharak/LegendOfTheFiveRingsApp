//
//  CharacterList.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI

struct CharacterList: View {
    @Binding var selection: Tab
    
    @State private var items: [String] = []

    var body: some View {
        NavigationView {
            Form {
                ForEach(items, id:\.self) { item in
                    NavigationLink(destination: Text("character: item")) {
                        Text(item)
                    }
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
            self.items.append("asd")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            print("delete")
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList(selection:.constant(Tab.characters))
    }
}
