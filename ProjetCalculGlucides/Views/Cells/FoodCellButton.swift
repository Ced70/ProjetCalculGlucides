//
//  FoodCellButton.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 06/01/2024.
//

import SwiftUI

struct FoodCellButton: View {
    
    @ObservedObject var food: Food
    @Binding var idSelected: String
    @State var isSelected: Bool = false
    
    
    init(food: Food, idSelected: Binding<String> = .constant("")) {
        self.food = food
        self._idSelected = idSelected
        self.isSelected = false
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(lineWidth: isSelected ? 3 : 1)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
                .foregroundColor(isSelected ? .blue : .primary)
            Button(action: {
                food.isSelected = !food.isSelected
                if idSelected != food.id.uuidString {
                    idSelected = food.id.uuidString
                } else {
                    idSelected = ""
                }
                
            }, label: {
                FoodCell(food: food)
            })
        }
        .onChange(of: food.isSelected) {
            isSelected = food.isSelected
        }
    }
}

#Preview {
    FoodCellButton(food: foodPreview)
}
