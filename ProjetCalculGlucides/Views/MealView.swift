//
//  MealView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct MealView: View {

    @ObservedObject var menuOfFoods : MenuOfFoods
    @ObservedObject var ratios : Ratios
    
    @State var buttonAddIsClicked = false
    
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
                Text("Ton ratio sans correction : 1 ui / \(String(ratios.actualRatio)) g")
                ScrollView {
                    VStack {
                        ForEach(menuOfFoods.list) { food in
                            NavigationLink {
                                DetailsFoodView(food: food)
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
                .padding()
                if !menuOfFoods.list.isEmpty {
                    Text("Total de glucides : \(String(format: "%.1f" , menuOfFoods.totalOfGlucids))")
                        .font(.title3)
                    Text("Dose d'insuline à prendre : \(String(format: "%.1f", menuOfFoods.doseInsuline))")
                        .font(.title3)
                        .foregroundStyle(.red)
                        .bold()
                }
            }
            .padding()
            .sheet(isPresented: $buttonAddIsClicked, content: {
                SearchView(menuOfFoods: menuOfFoods)
            })
            .onChange(of: ratios.actualRatio, {
                menuOfFoods.calculOfGlucidsTotal()
                menuOfFoods.calculOfInsulin()
            })
        }
    }
}

#Preview {
    MealView(menuOfFoods: MenuOfFoods(), ratios:Ratios())
}
