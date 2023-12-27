//
//  TimeOfDayButton.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct TimeOfDayButton: View {
    
    let text : String
    @ObservedObject var ratios : Ratios
    var timeOfDay : Ratios.TimeOfRatio
    
    var body: some View {
        Button(action: {
            ratios.timeOfRatioSelected = timeOfDay
        }, label: {
            ZStack {
                Circle()
                    .stroke(lineWidth: 2)
                    .frame(height: 70)
                Text(text)
                    .bold()
            }
        })
        .padding(4)
        .foregroundColor(ratios.timeOfRatioSelected == timeOfDay ? .blue : .primary)
    }
}

#Preview {
    TimeOfDayButton(text: "Matin", ratios: ratioPreview, timeOfDay: .snack)
}
