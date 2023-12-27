//
//  Food.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Food: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name : String = ""
    @Published var urlImage: String = ""
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
    
    func receiveInformationBarCode(barcodeScanned: String) async {
        let urlOpenFoodFacts = URL(string: "https://world.openfoodfacts.org")
        
        if let urlApi = URL(string: "/api/v2/product/", relativeTo: urlOpenFoodFacts) {
            let urlBarCode = urlApi.appendingPathComponent(barcodeScanned)
            
            do {
                let (data, _) = try await URLSession.shared.data(from: urlBarCode)
                
                // Tentez de convertir les données en JSON
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let product = jsonObject["product"] as? [String: Any] {
                    let name = product["product_name_fr"] as? String
                    let imageUrl = product["image_small_url"] as? String
                    let nutriments = product["nutriments"] as? [String: Any]
                    let glucidesPer100 = nutriments?["carbohydrates_100g"] as? Float
                    
                    DispatchQueue.main.async {
                        self.name = name ?? ""
                        self.urlImage = imageUrl ?? ""
                        self.glucidPerHundredGrams = glucidesPer100 ?? 0
                    }
                }
            } catch {
                print("Erreur lors de la requête ou du décodage JSON : \(error)")
            }
        } else {
            print("URL de base invalide")
        }
    }
}

var foodPreview = Food(name: "Test")
