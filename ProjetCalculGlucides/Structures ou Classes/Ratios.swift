//
//  Ratios.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import Foundation

class Ratios : ObservableObject, Codable {
    
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
    enum TimeOfRatio : String, Codable {
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
    
    enum CodingKeys: CodingKey {
        case valueBreakfast, valueLunch, valueSnack, valueDinner, timeOfRatioSelected
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        valueBreakfast = try container.decode(Int.self, forKey: .valueBreakfast)
        valueLunch = try container.decode(Int.self, forKey: .valueLunch)
        valueSnack = try container.decode(Int.self, forKey: .valueSnack)
        valueDinner = try container.decode(Int.self, forKey: .valueDinner)
        timeOfRatioSelected = try container.decode(TimeOfRatio.self, forKey: .timeOfRatioSelected)
        actualRatio = getActualRatio()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(valueBreakfast, forKey: .valueBreakfast)
        try container.encode(valueLunch, forKey: .valueLunch)
        try container.encode(valueSnack, forKey: .valueSnack)
        try container.encode(valueDinner, forKey: .valueDinner)
        try container.encode(timeOfRatioSelected, forKey: .timeOfRatioSelected)
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
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveToFile() {
        let filePath = getDocumentsDirectory().appendingPathComponent("Ratios.dat")
        
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: filePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Erreur lors de l'écriture du fichier: \(error)")
        }
    }
    
    func loadFromFile() {
        let filePath = getDocumentsDirectory().appendingPathComponent("Ratios.dat")
        
        do {
            let data = try Data(contentsOf: filePath)
            let decodedRatios = try JSONDecoder().decode(Ratios.self, from: data)
            self.valueBreakfast = decodedRatios.valueBreakfast
            self.valueLunch = decodedRatios.valueLunch
            self.valueSnack = decodedRatios.valueSnack
            self.valueDinner = decodedRatios.valueDinner
            self.timeOfRatioSelected = decodedRatios.timeOfRatioSelected
        } catch {
            print("Erreur lors de la lecture du fichier: \(error)")
        }
    }
}

var ratioPreview = Ratios()
