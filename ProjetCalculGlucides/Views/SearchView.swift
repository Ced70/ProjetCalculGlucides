//
//  SearchView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var meal : Meal
    
    @State var searchString : String = ""
    @State var barcodeButtonIsClicked = false
    @State var searchButtonIsClicked = false
    @State var addButtonIsClicked = false
    
    @StateObject var food = Food()
    
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
                    Spacer()
                    AddMenuButton(buttonIsClicked: $addButtonIsClicked)
                }
                else {
                    Spacer()
                }
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
        .onChange(of: addButtonIsClicked, {
            meal.list.append(food)
            searchString = ""
            food.name = ""
        })
    }
}

#Preview {
    SearchView(meal: Meal())
}
