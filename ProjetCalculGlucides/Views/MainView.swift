//
//  MainView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var meal = Meal()
    
    var body: some View {
        TabView {
            MealView(meal: meal, ratios: meal.ratios)
                .tabItem { 
                    VStack {
                        Image(systemName: "fork.knife")
                        Text("Repas") }
                    }
                    
            SearchView(meal: meal)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Rechercher")
                    }
                }
            RatiosView(ratios: meal.ratios)
                .tabItem {
                    VStack {
                        Image(systemName: "divide")
                        Text("Ratios")
                    }
                }
        }
        .onAppear(perform: {
            meal.ratios.loadFromFile()
        })
    }
}

#Preview {
    MainView()
}
