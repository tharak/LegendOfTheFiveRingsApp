//
//  DiceView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 03/12/20.
//

import SwiftUI
import LegendOfTheFiveRingsRoller

struct DiceView: View {

    @Binding var selection: Tab
    @State var roll: Int = 1
    @State var keep: Int = 1
    @State var bonus: Int = 0

    @State var keepHigh: Bool = true
    
    @State var explodesOn: Int? = 10
    @State var rerollOnOne: Bool = false

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Keep High")
                    Toggle(isOn: $keepHigh) {}.labelsHidden()
                }
                VStack {
                    Text("Explodes")
                    Picker("explodesOn:", selection: $explodesOn) {
                        ForEach([nil, 9, 10], id: \.self) { value in
                            Text(value == nil ? "none" : "\(value!)").tag(value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                VStack {
                    Text("Re-roll on 1")
                    Toggle(isOn: $rerollOnOne) {}.labelsHidden()
                }
            }
            .padding()
            HStack {
                ForEach(1...5, id: \.self) { i in
                    DieView(roll: .constant(i), keep: .constant(i), bonus: .constant(0), keepHigh: $keepHigh, explodesOn: $explodesOn, rerollOnOne: $rerollOnOne, color: .constant(Color.accentColor))
                }
            }
            VStack {
                HStack {
                    VStack {
                        Text("Roll")
                            .font(.headline)
                        Stepper("Roll", value: $roll, in: keep...30)
                            .labelsHidden()
                    }
                    .padding(.top, 4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))
                    Spacer()
                    VStack {
                        Text("Keep")
                            .font(.headline)
                        Stepper("Keep", value: $keep, in: 1...roll)
                            .labelsHidden()
                    }
                    .padding(.top, 4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))
                    Spacer()
                    VStack {
                        Text("Bonus")
                            .font(.headline)
                        Stepper("Bonus", value: $bonus)
                            .labelsHidden()
                    }
                    .padding(.top, 4)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))
                }
                DieView(roll: $roll, keep: $keep, bonus: $bonus, keepHigh: $keepHigh, explodesOn: $explodesOn, rerollOnOne: $rerollOnOne, color: .constant(Color.red))
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor, lineWidth: 1))
            .padding()
            HistoryView(selection: .constant(Tab.dice))
            Spacer()
        }
        .tabItem {
            Label("Dice", systemImage: selection == Tab.dice ? "hexagon.fill" : "hexagon")
                .accessibility(label: Text("Dice"))
        }
        .tag(Tab.dice)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(selection:.constant(Tab.dice))
            .environmentObject(LegendOfTheFiveRingsRollerModel())
    }
}
