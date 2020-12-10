//
//  RingView.swift
//  LegendOfTheFiveRingsApp
//
//  Created by Tharak on 10/12/20.
//

import SwiftUI
import LegendOfTheFiveRings

struct RingView: View {
    let ring: RingName
    @State var character: Character
    
    var body: some View {
        HStack {
            switch ring {
            case .fire, .air:
                Image(systemName: ring.systemImageName)
                    .font(.headline)
                Text("\(character.ring(name: ring))")
                    .font(.headline)
                Spacer()
                VStack (alignment: .trailing) {
                    ForEach(ring.traits, id:\.self) { trait in
                        TraitView(name: trait, trait: character.trait(name: trait))
                    }
                }
            
            case .water, .earth:
                VStack (alignment: .leading) {
                    ForEach(ring.traits, id:\.self) { trait in
                        TraitView(name: trait, trait: character.trait(name: trait))
                    }
                }
                Spacer()
                Text("\(character.ring(name: ring))")
                    .font(.headline)
                Image(systemName: ring.systemImageName)
                    .font(.headline)
            case .void :
                VStack {
                    Image(systemName: RingName.void.systemImageName)
                    HStack {
                        Text(RingName.void.rawValue.capitalized)
                        Text("\(character.ring(name: RingName.void))")
                    }
                }
                .font(.headline)
                .padding(8)
            }
        }
        .foregroundColor(ring.color)
    }
}

//struct RingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RingView(name: RingName.air, character: Character)
//    }
//}
