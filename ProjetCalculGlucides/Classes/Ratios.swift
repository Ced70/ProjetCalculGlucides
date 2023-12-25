//
//  Ratios.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Ratios : ObservableObject {
    
    @Published var matin : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var midi : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var gouter : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var soir : Int {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    @Published var actualRatio = 0
    
    enum TimeOfRatio {
        case matin
        case midi
        case gouter
        case soir
    }
    
    @Published var timeOfRatioSelected: TimeOfRatio = .matin {
        didSet {
            actualRatio = getActualRatio()
        }
    }
    
    init(matin: Int, midi: Int, gouter: Int, soir: Int) {
        self.matin = matin
        self.midi = midi
        self.gouter = gouter
        self.soir = soir
        actualRatio = getActualRatio()
    }
    
    func getActualRatio() -> Int {
        switch timeOfRatioSelected {
        case .matin :
            return matin
        case .midi :
            return midi
        case .gouter :
            return gouter
        case .soir :
            return soir
        }
    }
}

var ratioPreview = Ratios(matin: 10, midi: 20, gouter: 30, soir: 40)
