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
                RatioCell(systemName: "cup.and.saucer", text: "Matin", value: $ratios.valueBreakfast)
                RatioCell(systemName: "sun.max", text: "Midi", value: $ratios.valueLunch)
                RatioCell(systemName: "birthday.cake", text: "Goûter", value: $ratios.valueSnack)
                RatioCell(systemName: "moon", text: "Soir", value: $ratios.valueDinner)
                Text("1 ui / 8 g : représente 1 Unité d'insuline pour 8g de glucides")
                    .padding()
            }
            .padding()
            Spacer()
        }
        .onDisappear(perform: {
            ratios.saveToFile()
        })
    }
}

#Preview {
    RatiosView(ratios: ratioPreview)
}
