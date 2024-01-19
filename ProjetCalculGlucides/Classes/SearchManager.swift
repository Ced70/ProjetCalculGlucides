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
    var db : Connection?
    
    init() {
        self.resultsList = []
        self.db = nil
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
        var resultsList = searchToCiqual(textToSearch: textToSearch)
        resultsList.append(contentsOf: await searchToOpenfoodFacts(textToSearch: textToSearch))
        return resultsList
    }
    
    func searchToOpenfoodFacts(textToSearch: String) async -> [Food] {
        
        var urlBaseString = ""
        var endQueryString = ""
        var multipleSearch = false
        
        if isStringNumeric(textToSearch) {
            urlBaseString = "https://world.openfoodfacts.org/api/v2/product/"
        } else {
            urlBaseString = "https://world.openfoodfacts.org/cgi/search.pl?search_terms="
            endQueryString = "&search_simple=1&action=process&json=1"
            multipleSearch = true
        }
        
        var resultsList : [Food] = []
        
        if let encodedTerm = textToSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let completeURL = URL(string: urlBaseString + encodedTerm + endQueryString) {
            
            do {
                let (data, _) = try await URLSession.shared.data(from: completeURL)
                
                if multipleSearch {
                    let textResult = try? JSONDecoder().decode(AnswerTextSearch.self, from: data)
                    var maxNumber = textResult?.pageCount ?? 0
                    let resultsNumber = textResult?.count ?? 0
                    if resultsNumber < maxNumber {
                        maxNumber = resultsNumber
                    }
                    for i in 0..<(maxNumber) {
                        let foodTemp = Food()
                        foodTemp.name = textResult?.products[i].productNameFr ?? ""
                        foodTemp.urlImage = textResult?.products[i].imageSmallURL ?? ""
                        foodTemp.source = "OpenFoodFacts"
                        let glucidesTemp = textResult?.products[i].nutriments.carbohydrates100G
                        switch glucidesTemp {
                        case .string(let value):
                            foodTemp.glucidPerHundredGrams = Float(value.replacingOccurrences(of: ",", with: ".")) ?? 0.0
                        case .float(let value):
                            foodTemp.glucidPerHundredGrams = value
                        case .double(let value):
                            foodTemp.glucidPerHundredGrams = Float(value)
                        case .none:
                            foodTemp.glucidPerHundredGrams = 0.0
                        }
                        resultsList.append(foodTemp)
                    }
                } else {
                    let barcodeResult = try? JSONDecoder().decode(AnswerBarcode.self, from: data)
                    let foodTemp = Food()
                    foodTemp.name = barcodeResult?.product.productNameFr ?? ""
                    foodTemp.urlImage = barcodeResult?.product.imageSmallURL ?? ""
                    foodTemp.source = "OpenFoodFacts"
                    let glucidesTemp = barcodeResult?.product.nutriments.carbohydrates100G
                    switch glucidesTemp {
                    case .string(let value):
                        foodTemp.glucidPerHundredGrams = Float(value.replacingOccurrences(of: ",", with: ".")) ?? 0.0
                    case .float(let value):
                        foodTemp.glucidPerHundredGrams = value
                    case .double(let value):
                        foodTemp.glucidPerHundredGrams = Float(value)
                    case .none:
                        foodTemp.glucidPerHundredGrams = 0.0
                    }
                    resultsList.append(foodTemp)
                }
            } catch {
                print("Erreur lors de la requête ou du décodage JSON : \(error)")
            }
        } else {
            print("URL de base invalide")
        }
        return resultsList
    }
    
    func isStringNumeric(_ string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func searchToCiqual(textToSearch: String) -> [Food] {
        var resultsList : [Food] = []
        
        let databasePath = Bundle.main.path(forResource: "Ciqual_2020", ofType: "sqlite3")
        do {
            if let databasePath {
                try self.db = Connection(databasePath)
                print("DB ouverte")
                if let db = self.db {
                    let statement = try db.prepare("SELECT name FROM sqlite_master WHERE type='table'")
                    for table in statement {
                        if let tableName = table[0] as? String {
                            print("Table name: \(tableName)")
                        }
                    }
                    for row in try db.prepare("SELECT * FROM Ciqual_2020 WHERE alim_nom_fr LIKE '%\(textToSearch)%'") {
                        let foodTemp = Food()
                        foodTemp.name = row[7] as! String
                        foodTemp.glucidPerHundredGrams = Float((row[16] as! String).replacingOccurrences(of: ",", with: ".")) ?? 0.0
                        foodTemp.source = "Ciqual 2020"
                        resultsList.append(foodTemp)
                    }
                }
            }
        } catch {
            print("Erreur lors de l'ouverture de la DB")
        }
        return resultsList
    }
}
