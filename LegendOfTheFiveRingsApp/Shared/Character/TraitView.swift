//
//  TraitView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 10/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct TraitView: View {
    let name: TraitName
    let trait: Int

    var body: some View {
        HStack {
            switch name {
            case .stamina, .willpower, .strength, .perception:
                Text("\(trait)")
                Text(name.rawValue.capitalized)
            default:
                Text(name.rawValue.capitalized)
                Text("\(trait)")
            }
        }
        .font(.subheadline)
        .scaledToFit()
    }
}

struct TraitView_Previews: PreviewProvider {
    static var previews: some View {
        TraitView(name: TraitName.agility, trait: 2)
    }
}
