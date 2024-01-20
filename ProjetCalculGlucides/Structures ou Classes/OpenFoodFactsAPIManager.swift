//
//  OpenFoodFactsAPIManager.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 20/01/2024.
//

import Foundation


struct OpenFoodFactsAPIManager {
    
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
}
