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
    @State var listOfFoods : [Food] = [foodPreview]
    
    var body: some View {
        NavigationStack {
            VStack {
                TitleCell(text: "Mon repas")
                HStack {
                    TimeOfDayButton(
                        text: "Matin",
                        numberToActivate: 1,
                        actualNumberToCompare: $actualNumberToActivate)
                    TimeOfDayButton(
                        text: "Midi",
                        numberToActivate: 2,
                        actualNumberToCompare: $actualNumberToActivate)
                    TimeOfDayButton(
                        text: "Goûter",
                        numberToActivate: 3,
                        actualNumberToCompare: $actualNumberToActivate)
                    TimeOfDayButton(
                        text: "Soir",
                        numberToActivate: 4,
                        actualNumberToCompare: $actualNumberToActivate)
                }
                .padding()
                Text("Ton ratio sans correction : 1 ui / \(String(actualRatio)) g")
                ScrollView {
                    VStack {
                        ForEach($listOfFoods) { food in
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
        .onChange(of: actualNumberToActivate, {
            actualRatio = compareValueToPutRatio(ratios: ratios, valueActivated: actualNumberToActivate)
        })
    }
}

#Preview {
    MealView(ratios: ratioPreview)
}
