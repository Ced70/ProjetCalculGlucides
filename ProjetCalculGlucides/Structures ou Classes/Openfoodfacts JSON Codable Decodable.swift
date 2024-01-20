//
//  JSON Codable Decodable.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 29/12/2023.
//

import Foundation

// MARK: - TableauResultat
struct AnswerTextSearch: Codable {
    let pageCount: Int
    let products: [Product]
    let count: Int

    enum CodingKeys: String, CodingKey {
        case products = "products"
        case pageCount = "page_count"
        case count
    }
}

// MARK: - ResultatBarCode
struct AnswerBarcode: Codable {
    let code : String
    let product : Product
    let statusVerbose : String
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case product = "product"
        case statusVerbose = "status_verbose"
    }
}

// MARK: - Product
struct Product: Codable {
    let imageSmallURL: String?
    let nutriments: Nutriments
    let productNameFr: String?
    let abbreviatedProductNameFr : String?
    let nutriscore : Nutriscore?
    let ingredients : String?
    
    enum CodingKeys: String, CodingKey {
        case nutriments = "nutriments"
        case imageSmallURL = "image_small_url"
        case productNameFr = "product_name"
        case abbreviatedProductNameFr = "abbreviated_product_name_fr"
        case nutriscore
        case ingredients = "ingredients_text_fr"
    }
}

// MARK: - Nutriments
struct Nutriments: Codable {
    let carbohydrates100G: CarbohydrateValue

    enum CarbohydrateValue {
        case string(String)
        case float(Float)
        case double(Double)
    }

    enum CodingKeys: String, CodingKey {
        case carbohydrates100G = "carbohydrates_100g"
    }
}

extension Nutriments {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let floatValue = try? container.decode(Float.self, forKey: .carbohydrates100G) {
            carbohydrates100G = .float(floatValue)
        } else if let stringValue = try? container.decode(String.self, forKey: .carbohydrates100G) {
            carbohydrates100G = .string(stringValue)
        } else if let doubleValue = try? container.decode(Double.self, forKey: .carbohydrates100G) {
            carbohydrates100G = .double(doubleValue)
        } else {
            throw DecodingError.typeMismatch(CarbohydrateValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Expected a String or a Double"))
        }
    }
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch carbohydrates100G {
            case .string(let stringValue):
                try container.encode(stringValue, forKey: .carbohydrates100G)
            case .float(let floatValue):
                try container.encode(floatValue, forKey: .carbohydrates100G)
            case .double(let doubleValue):
                try container.encode(doubleValue, forKey: .carbohydrates100G)
            }
        }
}

// MARK - NutriScore
struct Nutriscore: Codable {
    let year2021 : Grade?
    let year2023 : Grade?
    
    enum CodingKeys: String, CodingKey {
        case year2021 = "2021"
        case year2023 = "2023"
    }
}

// MARK - Grade Nutriscore
struct Grade: Codable {
    let grade: String
    
    enum CodinkKeys: String, CodingKey {
        case grade
    }
}

