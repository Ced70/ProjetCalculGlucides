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
    @State var idSelected : String = ""
    @State var isLoading = false
    @ObservedObject var searchManager = SearchManager()
    
    @FocusState private var isTextFieldFocused: Bool
    
    @Environment(\.dismiss) var dismiss
    
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
                        .focused($isTextFieldFocused)
                    SearchButton(buttonIsClicked: $searchButtonIsClicked)
                }
                .padding()
                if isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(5)
                    Spacer()
                } else
                {
                    ScrollView {
                        if !searchManager.resultsList.isEmpty {
                            ForEach (searchManager.resultsList) { food in
                                FoodCellButton(food: food, idSelected: $idSelected)
                            }
                            Spacer()
                        }
                    }
                    if !(idSelected == "") {
                        AddMenuButton(buttonIsClicked: $addButtonIsClicked)
                    }
                }
            }
            .sheet(isPresented: $barcodeButtonIsClicked, content: {
                BarcodeReaderView(scannedCode: $searchString)
            })
            .onChange(of: searchButtonIsClicked, {
                searchButtonIsClicked = false
                isLoading = true
                isTextFieldFocused = false
                idSelected = ""
                Task {
                    searchManager.resultsList = await searchManager.search(textToSearch: searchString)
                }
                isLoading = false
            } )
            .onChange(of: addButtonIsClicked, {
                let foodToAdd = searchManager.searchFoodbyId(idSelected: idSelected)
                if let foodToAdd {
                    meal.list.append(foodToAdd)
                    searchString = ""
                    dismiss()
                }
            })
            .onChange(of: idSelected, {
                searchManager.updateSelection(idSelected: idSelected)
            })
        }
    }
}

#Preview {
    SearchView(meal: Meal())
}
