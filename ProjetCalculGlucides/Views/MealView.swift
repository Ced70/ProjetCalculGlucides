//
//  MealView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct MealView: View {

    @ObservedObject var meal : Meal
    @ObservedObject var ratios : Ratios
    
    @State var buttonAddIsClicked = false
    @State var idCellSelected : UUID?
    
    var body: some View {
        NavigationStack {
            VStack {
                TitleCell(text: "Mon repas")
                HStack {
                    TimeOfDayButton(
                        text: "Matin",
                        ratios: ratios,
                        timeOfDay: .breakfast)
                    TimeOfDayButton(
                        text: "Midi",
                        ratios: ratios,
                        timeOfDay: .lunch)
                    TimeOfDayButton(
                        text: "Goûter",
                        ratios: ratios,
                        timeOfDay: .snack)
                    TimeOfDayButton(
                        text: "Soir",
                        ratios: ratios,
                        timeOfDay: .dinner)
                }
                .padding()
                Text("Ratio sans correction : 1 ui / \(String(ratios.actualRatio)) g")
                ScrollView {
                    VStack {
                        ForEach(meal.list) { food in
                            NavigationLink {
                                DetailsFoodView(food: food, meal: meal)
                            } label: {
                                FoodCell(food: food)
                            }
                        }
                    }
                    Button(action: {
                        buttonAddIsClicked = true
                    }, label: {
                        VStack {
                            Text("Ajouter un aliment")
                                .font(.title2)
                            Image(systemName: "plus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 30)
                                .foregroundColor(.primary)
                        }.foregroundColor(.primary)
                    })
                }

                if !meal.list.isEmpty {
                    Text("Total de glucides : \(String(format: "%.1f" , meal.totalOfGlucids)) g")
                        .font(.title3)
                    Text("Dose d'insuline à prendre : \(String(format: "%.1f", meal.doseInsuline))")
                        .font(.title3)
                        .foregroundStyle(.red)
                        .bold()
                }
            }
            .padding()
            .sheet(isPresented: $buttonAddIsClicked, content: {
                SearchView(meal: meal)
            })
            .onChange(of: ratios.actualRatio, {
                meal.calculOfGlucidsTotal()
                meal.calculOfInsulin()
            })
            .onAppear(perform: {
                meal.calculOfGlucidsTotal()
                meal.calculOfInsulin()
            })
        }
    }
}

#Preview {
    MealView(meal: Meal(), ratios:Ratios())
}
