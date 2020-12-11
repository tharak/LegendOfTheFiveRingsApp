//
//  DiceView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 03/12/20.
//

import SwiftUI
import LegendOfTheFiveRingsRoller

struct DiceView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsRollerModel

    @Binding var selection: Tab    
    @State var roll: Int = 1
    @State var keep: Int = 1
    @State var bonus: Int = 0

    @State var keepHigh: Bool = true
    
    @State var explodesOn: Int? = 10
    @State var rerollOnOne: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text("Keep High")
                        Toggle(isOn: $keepHigh) {}.labelsHidden()
                    }
                    .padding(4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 2))
                    
                    Spacer()
                    VStack {
                        Text("Explodes")
                        Picker("explodesOn:", selection: $explodesOn) {
                            ForEach([nil, 9, 10], id: \.self) { value in
                                Text(value == nil ? "none" : "\(value!)").tag(value)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 2))
                    Spacer()
                    VStack {
                        Text("Re-roll on 1")
                        Toggle(isOn: $rerollOnOne) {}.labelsHidden()
                    }
                    .padding(4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 2))
                    Spacer()
                }
                HStack {
                    ForEach(1...5, id: \.self) { i in
                        Spacer()
                        DieView(model: model, roll: .constant(i), keep: .constant(i), bonus: .constant(0), keepHigh: $keepHigh, explodesOn: $explodesOn, rerollOnOne: $rerollOnOne, color: .constant(Color.accentColor))
                    }
                    Spacer()
                }

                Divider()
                VStack (spacing: 16) {
                    HStack {
                        VStack {
                            Text("Roll")
                            Stepper("Roll", value: $roll, in: keep...30)
                                .labelsHidden()
                        }
                        .padding(.top, 4)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))
                        Spacer()
                        VStack {
                            Text("Keep")
                            Stepper("Keep", value: $keep, in: 1...roll)
                                .labelsHidden()
                        }
                        .padding(.top, 4)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))
                        Spacer()
                        VStack {
                            Text("Bonus")
                            Stepper("Bonus", value: $bonus)
                                .labelsHidden()
                        }
                        .padding(.top, 4)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))
                    }
                    
                    DieView(model: model, roll: $roll, keep: $keep, bonus: $bonus, keepHigh: $keepHigh, explodesOn: $explodesOn, rerollOnOne: $rerollOnOne, color: .constant(Color.red))
                    
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))

                List {
                    ForEach(model.rolls, id: \.id) { (item: Roll) in
                        HStack {
                            Text(item.text).font(.subheadline)
                            Text(" [\(item.rolls)] = ").font(.subheadline)
                            Text("\(item.value)").font(.headline)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle("Dice", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        withAnimation {
                                            self.model.deleteAll()
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
            .padding()
        }
        .tabItem {
            Label("Dice", systemImage: selection == Tab.dice ? "hexagon.fill" : "hexagon")
                .accessibility(label: Text("Dice"))
        }
        .tag(Tab.dice)

    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for i in offsets {
                self.model.delete(roll: self.model.rolls[i])
            }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(selection:.constant(Tab.dice))
    }
}
