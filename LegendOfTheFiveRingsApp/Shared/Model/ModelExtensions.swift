//
//  ModelExtensions.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 09/12/20.
//
import SwiftUI
import LegendOfTheFiveRings

extension ClanName {
    
    static func emoji(name: String?) -> String {
        guard let unwrapName = name, let clanName = ClanName(rawValue: unwrapName) else {
            return name ?? ""
        }
        switch clanName {
        case .crab:
            return "🦀"
        case .crane:
            return "🦩"
        case .dragon:
            return "🐲"
        case .lion:
            return "🦁"
        case .mantis:
            return "🦗"
        case .phoenix:
            return "🐓"
        case .scorpion:
            return "🦂"
        case .spider:
            return "🕷"
        case .unicorn:
            return "🦄"
        case .badger:
            return "🦡"
        case .bat:
            return "🦇"
        case .boar:
            return "🐗"
        case .dragonfly:
            return "🪰"
        case .falcon:
            return "🦅"
        case .fox:
            return "🦊"
        case .hare:
            return "🐇"
        case .monkey:
            return "🐒"
        case .oriole:
            return "🦜"
        case .ox:
            return "🐂"
        case .snake:
            return "🐍"
        case .sparrow:
            return "🐥"
        case .tiger:
            return "🐅"
        case .tortoise:
            return "🐢"
        case .imperial:
            return "⚜️"
        case .ronin:
            return "🌊"
        }
    }
}

extension RingName {
    var traits: [TraitName] {
        switch self {
        case .air:
            return [TraitName.reflexes, TraitName.awareness]
        case .fire:
            return [TraitName.agility, TraitName.intelligence]
        case .water:
            return [TraitName.strength, TraitName.perception]
        case .earth:
            return [TraitName.stamina, TraitName.willpower]
        case .void:
            return [TraitName.void]
        }
    }
    
    var systemImageName: String {
        switch self {
        case .air:
            return "wind"
        case .fire:
            return "flame"
        case .water:
            return "drop"
        case .earth:
            return "leaf"
        case .void:
            return "camera.aperture"
        }
    }
    
    var color: Color {
        switch self {
        case .air:
            return Color.purple
        case .fire:
            return Color.red
        case .water:
            return Color.blue
        case .earth:
            return Color.yellow
        case .void:
            return Color.gray
        }
    }
}
