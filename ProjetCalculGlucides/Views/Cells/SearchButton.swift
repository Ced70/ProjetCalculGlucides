//
//  SearchButton.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct SearchButton: View {
    
    @Binding var buttonIsClicked : Bool
    
    var body: some View {
        Button(action: {
            buttonIsClicked = true
        }, label: {
            VStack {
                ZStack {
                    Capsule()
                        .stroke(lineWidth: 1)
                        .background(.green)
                        .cornerRadius(60)
                        .frame(width: 80, height: 25)
                    Text("Rechercher")
                        .font(.footnote)
                        .foregroundColor(.primary)
                }
            }
        })
    }
}

#Preview {
    SearchButton(buttonIsClicked: .constant(false))
}
