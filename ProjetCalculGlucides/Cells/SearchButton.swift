//
//  SearchButton.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        Button(action: {
            
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
    SearchButton()
}
