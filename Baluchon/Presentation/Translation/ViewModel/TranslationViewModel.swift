//
//  TranslationViewModel.swift
//  Baluchon
//
//  Created by Zidouni on 19/04/2023.
//
import SwiftUI
import Foundation
import Combine

class TranslationViewModel: ObservableObject {
    
    @Published var translatedText = ""
    private var cancellable: AnyCancellable?
        
    func translateText(_ text: String, source: String, target: String) {
        
        guard let envPath = Bundle.main.path(forResource: "Env", ofType: "plist"),
              let env = NSDictionary(contentsOfFile: envPath),
              let apiKey = env["TRANSLATION_API_KEY"] as? String else {
                  return
        }

        let url = URL(string: "https://translation.googleapis.com/language/translate/v2?key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "q": text,
            "source": source,
            "target": target,
            "format": "text"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: TranslationResponse.self, decoder: JSONDecoder())
            .map { response -> String in
                return response.data.translations.first?.translatedText ?? ""
            }
            .replaceError(with: "")
            .receive(on: DispatchQueue.main)
            .assign(to: \.translatedText, on: self)
    }
    
    func copyToClipboard(text: String) -> Bool{
        let copyboard = UIPasteboard.general
        copyboard.string = text
        return true
    }
    
    func pasteToClipBoard(text: String) -> String {
        let pasteboard = UIPasteboard.general
        let string = pasteboard.string
        return string!
        
    }
}

