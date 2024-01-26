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
    
    @State var weightWritted: String = ""
    
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
                            .alert("Choix du poids", isPresented: $addButtonIsClicked) {
                                HStack {
                                    TextField("", text: $weightWritted)
                                        .keyboardType(.numberPad)
                                    Button("Ok", action: {
                                        if let weightInt = Float(weightWritted) {
                                            let foodToAdd = searchManager.searchFoodbyId(idSelected: idSelected)
                                            if let foodToAdd {
                                                var food = Food()
                                                food = foodToAdd
                                                food.weight = weightInt
                                                meal.list.append(foodToAdd)
                                                searchString = ""
                                                dismiss()
                                            }
                                        }
                                    })
                                    Button("Annuler", role: .cancel, action: {})
                                }
                            } message: {
                                Text("Entrer le poids souhaité en g: ")
                            }
                    }
                }
            }
            .sheet(isPresented: $barcodeButtonIsClicked, content: {
                BarcodeReaderView(scannedCode: $searchString)
            })
            .onChange(of: searchButtonIsClicked, {
                if searchButtonIsClicked {
                    searchButtonIsClicked = false
                    isLoading = true
                    isTextFieldFocused = false
                    idSelected = ""
                    Task {
                        searchManager.resultsList = await searchManager.search(textToSearch: searchString)
                        isLoading = false
                    }
                }
            } )
            .onChange(of: idSelected, {
                searchManager.updateSelection(idSelected: idSelected)
            })
        }
    }
}

#Preview {
    SearchView(meal: Meal())
}
