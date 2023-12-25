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
    @State var searchButtonIsClicked = false
    
    @StateObject var food = Food(name: "", weight: 0, glucidPerHundredGrams: 0, urlImage: "")
    
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
                    SearchButton(buttonIsClicked: $searchButtonIsClicked)
                }
                if !food.name.isEmpty {
                    FoodCell(food: food)
                }
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $barcodeButtonIsClicked, content: {
            BarcodeReaderView(scannedCode: $searchString)
        })
        .onChange(of: searchButtonIsClicked, {
            Task {
                await food.receiveInformationBarCode(barcodeScanned: searchString)
                print("SearchView : food.name = \(food.name)")
            }
        } )
    }
}

#Preview {
    SearchView()
}
