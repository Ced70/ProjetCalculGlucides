//
//  MenuOfFoods.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 26/12/2023.
//

import Foundation

class Meal : ObservableObject {
    @Published var list : [Food] = [] {
        didSet {
            calculOfGlucidsTotal()
        }
    }
    @Published var totalOfGlucids : Float = 0.0 {
        didSet {
            calculOfInsulin()
        }
    }
    
    @Published var ratios = Ratios()
    
    var doseInsuline : Float = 0.0
    
    func calculOfGlucidsTotal() {
        totalOfGlucids = 0.0
        for food in self.list {
            totalOfGlucids = totalOfGlucids + food.glucids
        }
    }
    
    func calculOfInsulin() {
        doseInsuline = totalOfGlucids / Float(ratios.actualRatio)
    }
}


