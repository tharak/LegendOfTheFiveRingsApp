//
//  BuyEquipments.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 26/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct BuyEquipments: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @EnvironmentObject var book: Book
    @ObservedObject var character: Character
    
    @State private var showingAlert = false
    @State private var weaponName = ""
    @State private var weaponDescription = ""

    @State private var type: EquipmentType = EquipmentType.weapon
    
    let weaponTypes = ["Sword", "Heavy", "Knives", "Polearm", "Spear", "Arrow", "Bow", "Chain", "Stave", "War Fan", "Ninjutsu", "Firearm", "Cannon", "Sling"]
    
    var body: some View {
        Form {
            switch type {
            case .weapon:
                ForEach(weaponTypes, id:\.self) { weaponType in
                    Section(header: Text(weaponType)) {
                        ForEach(book.weapons.filter({weaponType == $0.type}), id:\.self) { (weapon: Weapon) in
                            BuyWeaponView(character: character, weapon: weapon, weaponName: $weaponName, weaponDescription: $weaponDescription, showingAlert: $showingAlert)
                        }
                    }
                }
            case .armor:
                Section {
                    ForEach(book.armors, id:\.self) { (armor: Armor) in
                        BuyArmorView(character: character, armor: armor)
                    }
                }
            }
        }
        .navigationBarItems(trailing:
            HStack {
                Picker("Equipment", selection: $type) {
                    ForEach([EquipmentType.weapon, EquipmentType.armor], id: \.self) { index in
                        Text(index.rawValue).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        )
        .navigationTitle("Money: \(character.xp)")
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(weaponName), message: Text(weaponDescription))
        }
    }
    
    enum EquipmentType: String {
        case weapon = "Weapons", armor = "Armors"
    }
}

struct BuyArmorView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @ObservedObject var character: Character
    let armor: Armor

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(armor.name)
                    .font(.headline)
                Spacer()
                Button(action: {
                    model.buyArmors(name: armor.name, for: character)
                }) {
                    Label(armor.price, systemImage: "cart.circle")
                        .font(.body)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            HStack {
                Spacer()
                if armor.tn.count == 2 {
                    HStack {
                        Text("TN: ")
                        ForEach(armor.tn, id: \.self) { (value: Int) in
                            Text("\(value)").tag(value)
                            Divider().fixedSize()
                        }
                    }
                } else {
                    Text("TN: \(armor.tn.first ?? 0)")
                }
                Spacer()
                Text("Reduction: \(armor.reduction)")
                Spacer()
            }
            if let special = armor.special {
                Text(special)
                    .font(.footnote)
            }
            Text(armor.description)
                .font(.caption)

        }
    }
}


struct BuyWeaponView: View {
    @EnvironmentObject var model: LegendOfTheFiveRingsModel
    @ObservedObject var character: Character
    let weapon: Weapon
    @Binding var weaponName: String
    @Binding var weaponDescription: String
    @Binding var showingAlert: Bool
    
    var body: some View {
        VStack (spacing: 4) {
            HStack {
                Text(weapon.name)
                    .font(.headline)
                Spacer()
                if let dr = weapon.dr {
                    Divider().fixedSize()
                    Text(dr)
                }
                if let price = weapon.price {
                    Divider().fixedSize()
                    Button(action: {
                        model.buyWeapons(name: weapon.name, for: character)
                    }) {
                        Label(price, systemImage: "cart.circle")
                            .font(.body)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                if let description = weapon.description {
                    Divider().fixedSize()
                    Button(action: {
                        weaponName = weapon.name
                        weaponDescription = description
                        showingAlert.toggle()
                    }) {
                        Label("Description", systemImage: "info.circle")
                            .labelStyle(IconOnlyLabelStyle())
                            .font(.body)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            HStack {
                if let keywords = weapon.keywords {
                    Text(keywords)
                        .font(.subheadline)
                    Spacer()
                }
                if let range = weapon.range {
                    Divider().fixedSize()
                    Text("Range: \(range)")
                }
            }
            if let special = weapon.special {
                Text(special)
                    .font(.footnote)
            }
        }
    }
}
