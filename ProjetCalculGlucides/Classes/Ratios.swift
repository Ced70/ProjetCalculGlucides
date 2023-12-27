//
//  Ratios.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Ratios : ObservableObject {
    
    @Published var valueBreakfast : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var valueLunch : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var valueSnack : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var valueDinner : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var actualRatio : Int = 0
    enum TimeOfRatio {
        case breakfast
        case lunch
        case snack
        case dinner
    }
    @Published var timeOfRatioSelected: TimeOfRatio = .breakfast {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    
    init() {
        valueBreakfast = 10
        valueLunch = 15
        valueSnack = 20
        valueDinner = 25
        actualRatio = getActualRatio()
    }
        
    func getActualRatio() -> Int {
        switch timeOfRatioSelected {
        case .breakfast :
            return valueBreakfast
        case .lunch :
            return valueLunch
        case .snack :
            return valueSnack
        case .dinner :
            return valueDinner
        }
    }
}

var ratioPreview = Ratios()
