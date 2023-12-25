//
//  TimeOfDayButton.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct TimeOfDayButton: View {
    
    let text : String
    let numberToActivate : Int
    @Binding var actualNumberToCompare : Int
    
    var body: some View {
        Button(action: {
            actualNumberToCompare = numberToActivate
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
        .foregroundColor(numberToActivate == actualNumberToCompare ? .blue : .primary)
    }
}

#Preview {
    TimeOfDayButton(text: "Matin", numberToActivate: 1, actualNumberToCompare: .constant(1))
}
