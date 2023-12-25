//
//  TitleCell.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct TitleCell: View {
    
    let text : String
    
    var body: some View {
        Text(text)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .bold()
            .padding()
    }
}

#Preview {
    TitleCell(text : "Mes repas")
}
