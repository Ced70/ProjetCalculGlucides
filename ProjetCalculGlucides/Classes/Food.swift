//
//  Food.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Food: ObservableObject {
    @Published var name : String
    @Published var weight : Int
    @Published var glucidPerHundredGrams : Float
    @Published var urlImage : URL
    
    init(name: String, weight: Int, glucidPerHundredGrams: Float, urlImage: URL) {
        self.name = name
        self.weight = weight
        self.glucidPerHundredGrams = glucidPerHundredGrams
        self.urlImage = urlImage
    }
    
}
