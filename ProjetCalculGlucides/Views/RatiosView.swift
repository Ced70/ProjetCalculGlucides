//
//  RatiosView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct RatiosView: View {
    
    @ObservedObject var ratios : Ratios
    
    var body: some View {
        VStack {
            TitleCell(text: " Mes ratios")
            VStack {
                RatioCell(systemName: "cup.and.saucer", text: "Matin", value: $ratios.matin)
                RatioCell(systemName: "sun.max", text: "Midi", value: $ratios.midi)
                RatioCell(systemName: "birthday.cake", text: "Goûter", value: $ratios.gouter)
                RatioCell(systemName: "moon", text: "Soir", value: $ratios.soir)
                Text("1 ui / 8 g : représente 1 Unité d'insuline pour 8g de glucides")
                    .padding()
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    RatiosView(ratios: ratioPreview)
}
