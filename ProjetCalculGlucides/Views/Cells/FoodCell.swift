//
//  FoodCell.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct FoodCell: View {
    
    @ObservedObject var food: Food
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(lineWidth: 1)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
                .foregroundColor(.primary)
            HStack {
                AsyncImage(url: URL(string: food.urlImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondary)
                        Text("Source Ciqual")
                            .font(.footnote)
                            .foregroundStyle(.primary)
                    }
                    
                }.aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipped()
                    .padding(.horizontal, 5)
                VStack (alignment: .leading) {
                    Text(food.name)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    Text("Poids : \(String(format: "%g", food.weight)) g")
                        .foregroundColor(.primary)
                }
                Spacer()
                VStack {
                    Text("Glucides :")
                    Text(" \(String(format: "%g", food.glucids)) g")
                }
                .foregroundColor(.red)
                .padding()
            }
            .padding(5)
        }
    }
}

#Preview {
    FoodCell(food: foodPreview)
}
