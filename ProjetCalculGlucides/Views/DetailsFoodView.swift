//
//  DetailsFoodView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 27/12/2023.
//

import SwiftUI

struct DetailsFoodView: View {
    
    @ObservedObject var food : Food
    
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
        ScrollView {
            AsyncImage(url: URL(string:food.urlImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
            }.aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            Text(food.name)
                .font(.title)
            VStack(alignment: .leading) {
                HStack{
                    Text("Masse : ")
                        .font(.title2)
                    TextField("", text: poids)
                        .font(.title2)
                        .frame(maxWidth: 50)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .keyboardType(.numberPad)
                    Text("g")
                        .font(.title2)
                    Spacer()
                }
                .padding()
                HStack {
                    Text("Glucides pour 100 g : \(String(format : "%.1f", food.glucidPerHundredGrams)) g")
                        .font(.title2)
                }
                .padding()
                
            }
        }
    }
}

#Preview {
    DetailsFoodView(food: Food())
}
