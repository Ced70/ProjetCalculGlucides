//
//  AddMenuButton.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 27/12/2023.
//

import SwiftUI

struct AddMenuButton: View {
    
    @Binding var buttonIsClicked : Bool
    
    var body: some View {
        Button(action: {
            buttonIsClicked = true
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.green)
                    .frame(width: 150, height: 40)
                Text("Ajouter")
                    .foregroundStyle(.primary)
                    .font(.title2)
            }
        })
    }
}

#Preview {
    AddMenuButton(buttonIsClicked: .constant(true))
}
