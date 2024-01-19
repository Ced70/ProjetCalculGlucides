//
//  DeleteButton.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 28/12/2023.
//

import SwiftUI

struct DeleteButton: View {
    
    @Binding var buttonIsClicked : Bool
    
    var body: some View {
        Button {
            buttonIsClicked = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
                    .frame(width: 200, height: 50)
                Text("Supprimer")
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    DeleteButton(buttonIsClicked: .constant(false))
}
