//
//  Currency.swift
//  Baluchon
//
//  Created by Zidouni on 24/04/2023.
//

import Foundation

struct CurrencyResponse: Codable {
    let data: [String: CurrencyAmount]
}

struct CurrencyAmount: Codable {
    let code: String
    let value: Double
}

enum Currency: String {
    case euro = "€"
    case dollar = "$"
    
    var currency: String {
        switch self {
        case .euro:
            return "EUR"
        case .dollar:
            return "USD"
        }
    }
}
