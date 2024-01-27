//
//  DetailsFoodView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 27/12/2023.
//

import SwiftUI

struct DetailsFoodView: View {
    
    @ObservedObject var food : Food
    @ObservedObject var meal : Meal
    @State var buttonDeleteIsClicked : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @FocusState private var isInputActive: Bool
    
    private var poids: Binding<String> {
        Binding<String>(
            get: {
                String(format: "%.0f", food.weight)
            },
            set: {
                if let value = Float($0) {
                    food.weight = value
                }
            }
        )
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string:food.urlImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 200, height: 200)
                    Text("Pas d'image")
                        .foregroundStyle(.primary)
                        .font(.title)
                }
            }.aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .clipped()
            Text(food.name)
                .font(.title)
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    HStack{
                        Text("Masse : ")
                            .font(.title2)
                        TextField("", text: poids)
                            .focused($isInputActive)
                            .font(.title2)
                            .frame(maxWidth: 50)
                            .foregroundColor(.blue)
                            .keyboardType(.numberPad)
                            .toolbar(content: {
                                ToolbarItem(placement: .keyboard, content: {
                                    Button(action: {
                                        isInputActive = false
                                    }, label: {
                                        Text("Valider")
                                            .foregroundStyle(.green)
                                            .bold()
                                    })
                                })
                            })
                        Text("g")
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Text("Pour 100 g : ")
                            .font(.title2)
                        Text(String(format : "%.1f", food.glucidPerHundredGrams))
                            .foregroundStyle(.red)
                            .font(.title2)
                        Text(" g de glucides")
                            .font(.title2)
                    }
                    if food.weight != 100 {
                        HStack {
                            Text("Pour ")
                                .font(.title2)
                            Text(String(format : "%.0f", food.weight))
                                .foregroundStyle(.red)
                                .font(.title2)
                            Text(" g : ")
                                .font(.title2)
                            Text(String(format : "%.1f", food.glucids))
                                .foregroundStyle(.red)
                                .font(.title2)
                            Text(" g de glucides")
                                .font(.title2)
                        }
                    }
                    Text("Source : \(food.source)")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 10)
                        .lineLimit(3)
                }.padding()
            }
            Spacer()
            DeleteButton(buttonIsClicked: $buttonDeleteIsClicked)
        }.padding()
            .onChange(of: buttonDeleteIsClicked) {
                if let index = meal.list.firstIndex(where: { $0.id == food.id }) {
                    meal.list.remove(at: index)
                }
                presentationMode.wrappedValue.dismiss()
            }
    }
}

#Preview {
    DetailsFoodView(food: Food(), meal: Meal())
}
