//
//  FrameworkTestView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 28/11/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct FrameworkTestView: View {
    
    let book = Book()

    var body: some View {
        NavigationView {
            ListView(name: "Book", sections: [
                SectionData(name: "Advantages", items: book.advatages.map({$0.name})),
                SectionData(name: "Ancestors", items: book.ancestors.map({$0.name})),
                SectionData(name: "Armors", items: book.armors.map({$0.name})),
                SectionData(name: "Clans", items: book.clans.map({$0.name})),
                SectionData(name: "Disadvatages", items: book.disadvatages.map({$0.name})),
                SectionData(name: "Families", items: book.families.map({$0.name})),
                SectionData(name: "Katas", items: book.katas.map({$0.name})),
                SectionData(name: "Kihos", items: book.kihos.map({$0.name})),
                SectionData(name: "schools", items: book.schools.map({$0.name})),
                SectionData(name: "shadowlandsPowers", items: book.shadowlandsPowers.map({$0.name})),
                SectionData(name: "Skills", items: book.skills.map({$0.name})),
                SectionData(name: "Spells", items: book.spells.map({$0.name})),
                SectionData(name: "Tattoos", items: book.tattoos.map({$0.name})),
                SectionData(name: "Weapons", items: book.weapons.map({$0.name})),
            ])
        }
        .tabItem {
            Label("book", systemImage: "book.closed")
        }
    }
}

struct SectionData: Hashable {
    let name: String
    let items: [String]
}

struct ListView: View {
    let name: String
    let sections: [SectionData]

    var body: some View {
        List  {
            ForEach(sections, id: \.self) { section in
                SectionView(name: section.name, sectionItems: section.items)
            }
        }
        .navigationBarItems(leading: Text(""), trailing: Text("") )
        .navigationBarTitle(name)
    }
}

struct SectionView: View {
    let name: String
    let sectionItems: [String]
    var body: some View {
        Section(header:
            Text(name)) {
            ForEach(sectionItems, id: \.self) {
                Text($0)
            }
        }
    }
}

struct FrameworkTestView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkTestView()
    }
}
