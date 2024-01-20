//
//  SearchManager.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 29/12/2023.
//

import Foundation
import SQLite

class SearchManager: ObservableObject {
    
    @Published var resultsList : [Food] = []
    
    init() {
        self.resultsList = []
    }
    
    func updateSelection(idSelected: String) {
        for index in resultsList.indices {
            resultsList[index].isSelected = resultsList[index].id.uuidString == idSelected
        }
    }
    
    func searchFoodbyId(idSelected: String) -> Food? {
        return resultsList.first { $0.id.uuidString == idSelected }
    }
    
    func search(textToSearch: String) async -> [Food] {
        var resultsList = CiqualDBManager().searchToCiqual(textToSearch: textToSearch)
        resultsList.append(contentsOf: await OpenFoodFactsAPIManager().searchToOpenfoodFacts(textToSearch: textToSearch))
        return resultsList
    }
}
