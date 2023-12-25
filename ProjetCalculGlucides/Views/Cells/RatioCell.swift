//
//  RatioCell.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct RatioCell: View {
    
    let systemName : String
    let text : String
    
    @Binding var value : Int
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: systemName)
                    .font(.title2)
                Text(text)
                    .font(.title2)
            }
            .frame(maxWidth: 75)
            .padding()
            
            Stepper("1 ui / \(value) g") {
                value = value + 1
            } onDecrement: {
                value = value - 1
            }
            .font(.title3)
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    RatioCell(systemName: "cup.and.saucer.fill", text: "Matin", value: .constant(5))
}
