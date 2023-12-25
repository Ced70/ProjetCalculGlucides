//
//  Food.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Food: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name : String
    @Published var urlImage: String
    @Published var weight: Float {
        didSet {
            calculGlucides()
        }
    }
    @Published var glucidPerHundredGrams: Float {
        didSet {
            calculGlucides()
        }
    }
    @Published var glucids : Float = 0.0
    
    init(name: String, weight: Float, glucidPerHundredGrams: Float, urlImage: String) {
        self.name = name
        self.weight = weight
        self.glucidPerHundredGrams = glucidPerHundredGrams
        self.urlImage = urlImage
        calculGlucides()
    }
    
    func calculGlucides() {
        glucids = (weight / 100) * glucidPerHundredGrams
    }
}

var foodPreview = Food(name: "Frites",
                       weight: 120,
                       glucidPerHundredGrams: 75,
                       urlImage: "https://media.istockphoto.com/id/531189325/fr/photo/restauration-rapide.jpg?s=2048x2048&w=is&k=20&c=TN4IbP_7cBwsP5-UuRDNcUjiMhqaO6CIlC5lFaqMuAM="
)
