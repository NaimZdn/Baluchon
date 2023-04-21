//
//  Traduction.swift
//  Baluchon
//
//  Created by Zidouni on 19/04/2023.
//

import Foundation

struct TranslationResponse: Codable {
    let data: TranslationData
}

struct TranslationData: Codable {
    let translations: [TranslatedText]
}

struct TranslatedText: Codable {
    let translatedText: String
}
