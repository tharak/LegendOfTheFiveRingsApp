//
//  CharacterList.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI

struct CharacterList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var selection: Tab
    
    var body: some View {
        NavigationView {
            Text("Characters")
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
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList(selection:.constant(Tab.characters))
    }
}
