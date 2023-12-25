//
//  FoodCell.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct FoodCell: View {
    
    @Binding var food : Food
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 0)
                .padding(.vertical, 5)
                .foregroundColor(.primary)
            HStack {
                AsyncImage(url: URL(string: food.urlImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                }.aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipped()
                VStack (alignment: .leading) {
                    Text(food.name)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    Text("Poids : \(String(format: "%g", food.weight)) g")
                }
                VStack {
                    Text("Glucides :")
                    Text(" \(String(format: "%g", food.glucids)) g")
                }
                .foregroundColor(.red)
                Spacer()
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
            }
            .padding(5)
        }
    }
}

#Preview {
    FoodCell(food: .constant(foodPreview))
}
