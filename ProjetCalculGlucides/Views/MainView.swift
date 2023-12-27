//
//  MainView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var menuOfFoods = MenuOfFoods()
    
    var body: some View {
        TabView {
            MealView(menuOfFoods: menuOfFoods, ratios: menuOfFoods.ratios)
                .tabItem { 
                    VStack {
                        Image(systemName: "fork.knife")
                        Text("Repas") }
                    }
                    
            SearchView(menuOfFoods: menuOfFoods)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Rechercher")
                    }
                }
            RatiosView(ratios: menuOfFoods.ratios)
                .tabItem {
                    VStack {
                        Image(systemName: "divide")
                        Text("Ratios")
                    }
                    
                }
        }
    }
}

#Preview {
    MainView()
}
