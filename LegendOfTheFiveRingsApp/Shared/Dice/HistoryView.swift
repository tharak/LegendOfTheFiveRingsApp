//
//  RollHistory.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 12/12/20.
//

import SwiftUI
import LegendOfTheFiveRingsRoller

struct HistoryView: View {
    @EnvironmentObject var roller: LegendOfTheFiveRingsRollerModel
    @Binding var selection: Tab

    var body: some View {
        List {
            ForEach(roller.rolls, id: \.id) { (item: Roll) in
                HStack {
                    Text(item.text).font(.subheadline)
                    Text(" [\(item.rolls)] = ").font(.subheadline)
                    Text("\(item.value)").font(.headline)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationBarItems(leading:
            Button(action: {
                withAnimation {
                    self.roller.deleteAll()
                }
            }) {
                Label("delete all", systemImage: "trash")
            },
            trailing:
                HStack {
                    #if os(iOS)
                    EditButton()
                    #endif
                }
        )
        .navigationBarTitle("Rolls", displayMode: .inline)
    
        .tabItem {
            Label("Rolls", systemImage: selection == Tab.history ? "doc.plaintext.fill" : "doc.plaintext")
                .accessibility(label: Text("Rolls"))
        }
        .tag(Tab.history)
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for i in offsets {
                self.roller.delete(roll: self.roller.rolls[i])
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(selection:.constant(Tab.history))
            .environmentObject(LegendOfTheFiveRingsRollerModel())
    }
}
