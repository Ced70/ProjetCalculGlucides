//
//  MainView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var ratios = Ratios(matin: 15, midi: 15, gouter: 15, soir: 15)
    
    var body: some View {
        TabView {
            MealView(ratios: ratios)
                .tabItem { 
                    VStack {
                        Image(systemName: "fork.knife")
                        Text("Repas") }
                    }
                    
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Rechercher")
                    }
                }
            RatiosView(ratios: ratios)
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
