//
//  compareValueToPutRatio.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

func compareValueToPutRatio(ratios : Ratios, valueActivated : Int) -> Int {
    switch valueActivated {
    case 1 :
        return ratios.matin
    case 2 :
        return ratios.midi
    case 3 :
        return ratios.gouter
    case 4 :
        return ratios.soir
    default:
        return 0
    }
}
