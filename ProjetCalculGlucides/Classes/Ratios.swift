//
//  Ratios.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Ratios : ObservableObject {
    @Published var matin : Int
    @Published var midi : Int
    @Published var gouter : Int
    @Published var soir : Int
    
    init(matin: Int, midi: Int, gouter: Int, soir: Int) {
        self.matin = matin
        self.midi = midi
        self.gouter = gouter
        self.soir = soir
    }
}

var ratioPreview = Ratios(matin: 10, midi: 20, gouter: 30, soir: 40)
