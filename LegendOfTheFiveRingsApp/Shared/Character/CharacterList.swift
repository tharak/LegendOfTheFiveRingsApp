//
//  CharacterList.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct CharacterList: View {

    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @EnvironmentObject var book: Book
    @Binding var selection: Tab
    @State var showCharacterCreation = false

    var body: some View {
        NavigationView {
            Form {
                ForEach(model.characters, id: \.id) { (character: Character) in
                    NavigationLink(destination: CharacterView(character: character)) {
                        CharacterCell(character: character)
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
                        Label("create", systemImage: "plus")
                    }.sheet(isPresented: $showCharacterCreation) {
                        CharacterCreationView(book: book, showing: self.$showCharacterCreation)
                    }
                    #if os(iOS)
                    Divider()
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
            .environmentObject(LegendOfTheFiveRingsModel())
            .environmentObject(Book())
    }
}
