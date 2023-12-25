//
//  SearchView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchString : String = ""
    @State var barcodeButtonIsClicked = false
    
    var body: some View {
        VStack {
            TitleCell(text: "Rechercher")
            VStack {
                HStack {
                    Button(action: {
                        barcodeButtonIsClicked = true
                    }, label: {
                        Image(systemName: "barcode.viewfinder")
                            .font(.title)
                            .foregroundColor(.primary)
                    })
                    TextField("Aliment à rechercher ...", text: $searchString)
                }
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $barcodeButtonIsClicked, content: {
            BarcodeReaderView(scannedCode: $searchString)
        })
    }
}

#Preview {
    SearchView()
}
