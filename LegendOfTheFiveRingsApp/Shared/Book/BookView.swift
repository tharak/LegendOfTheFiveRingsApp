//
//  FrameworkTestView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct BookView: View {
    
    @Binding var selection: Tab
    @EnvironmentObject var book: Book

    var body: some View {
        let sections = [
            SectionView(name: "Advantages", items: book.advatages.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Ancestors", items: book.ancestors.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Armors", items: book.armors.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Clans", items: book.clans.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Disadvatages", items: book.disadvatages.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Families", items: book.families.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Katas", items: book.katas.map({NameDescription($0.name, $0.description)})),
        
            SectionView(name: "Kihos", items: book.kihos.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Schools", items: book.schools.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Shadowlands Powers", items: book.shadowlandsPowers.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Skills", items: book.skills.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Spells", items: book.spells.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Tattoos", items: book.tattoos.map({NameDescription($0.name, $0.description)})),
            SectionView(name: "Weapons", items: book.weapons.map({NameDescription($0.name, $0.description ?? "")})),
        ]
        NavigationView {
            Form  {
                ForEach(sections, id: \.self) { sectionView in
                    sectionView
                }
            }
            .navigationBarTitle("Book", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .tabItem {
            Label("Book", systemImage: selection == Tab.book ? "book.closed.fill" : "book.closed")
        }
        .tag(Tab.book)
    }
}

struct SectionView: View, Hashable {
    let name: String
    let items: [NameDescription]
    var body: some View {
        NavigationLink(destination:
            List {
                ForEach(items, id: \.self) {
                    Text($0.name).font(.headline)
                    Text($0.description).font(.subheadline)
                }
            }
            .navigationBarTitle(name, displayMode: .inline)
        ) {
            Text(name)
        }
    }
}

struct NameDescription: Hashable {
    init(_ name: String, _ description: String) {
        self.name = name
        self.description = description
    }
    
    let name, description: String
}

struct BookViewTestView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(selection: .constant(Tab.book))
    }
}
