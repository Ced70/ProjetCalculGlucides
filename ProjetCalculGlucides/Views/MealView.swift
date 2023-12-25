//
//  MealView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct MealView: View {
    
    @State var buttonAddIsClicked = false
    @State var actualRatio : Int = 1
    @State var actualNumberToActivate = 1
    
    @ObservedObject var ratios : Ratios
    @StateObject var menuOfFoods = MenuOfFoods()
    
    var body: some View {
        NavigationStack {
            VStack {
                TitleCell(text: "Mon repas")
                HStack {
                    TimeOfDayButton(
                        text: "Matin",
                        ratios: ratios,
                        timeOfDay: .matin)
                    TimeOfDayButton(
                        text: "Midi",
                        ratios: ratios,
                        timeOfDay: .midi)
                    TimeOfDayButton(
                        text: "Goûter",
                        ratios: ratios,
                        timeOfDay: .gouter)
                    TimeOfDayButton(
                        text: "Soir",
                        ratios: ratios,
                        timeOfDay: .soir)
                }
                .padding()
                Text("Ton ratio sans correction : 1 ui / \(String(ratios.actualRatio)) g")
                ScrollView {
                    VStack {
                        ForEach(menuOfFoods.list) { food in
                            NavigationLink {
                                Text("Test")
                            } label: {
                                FoodCell(food: food)
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
                                .padding()
                        })
                    }
                }
                .padding()
            }
            .sheet(isPresented: $buttonAddIsClicked, content: {
                SearchView()
            })
        }
    }
}

#Preview {
    MealView(ratios: ratioPreview)
}
