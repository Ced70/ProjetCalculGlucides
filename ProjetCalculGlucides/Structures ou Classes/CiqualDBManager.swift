//
//  CiqualDBManager.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 20/01/2024.
//

import Foundation
import SQLite

struct CiqualDBManager {
    
    func searchToCiqual(textToSearch: String) -> [Food] {
        var resultsList : [Food] = []
        
        let databasePath = Bundle.main.path(forResource: "Ciqual_2020", ofType: "sqlite3")
        do {
            if let databasePath {
                var db : Connection?
                db = try Connection(databasePath)
                print("DB ouverte")
                if let db {
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
