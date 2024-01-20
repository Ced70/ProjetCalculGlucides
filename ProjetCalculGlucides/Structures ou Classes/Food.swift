//
//  Food.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Food: ObservableObject, Identifiable {
    let id = UUID()
    var name : String = ""
    var urlImage : String = ""
    var source : String = ""
    @Published var isSelected : Bool = false
    
    @Published var weight: Float = 100.0 {
        didSet {
            calculGlucides()
        }
    }
    @Published var glucidPerHundredGrams: Float = 0.0 {
        didSet {
            calculGlucides()
        }
    }
    @Published var glucids : Float = 0.0
    
    init() {
        calculGlucides()
    }
    
    init(name : String) {
        self.name = name
        calculGlucides()
    }
    
    func calculGlucides() {
        glucids = (weight / 100) * glucidPerHundredGrams
    }
}

var foodPreview = Food(name: "Test")
