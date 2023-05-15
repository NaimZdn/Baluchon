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
    @Published var isLoading = true
    @Published var isFailure = true
    
    private var translationData: TranslationResponse = .init(data: .init(translations: []) )
    private var cancellable: AnyCancellable?
    private var requestError: Errors? = nil
    
    private func getAPIKey(fromFileNamed fileName: String) throws -> String {
        guard let envPath = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let env = NSDictionary(contentsOfFile: envPath),
              let apiKey = env["TRANSLATION_API_KEY"] as? String else {
            throw Errors.apiKeyNotFound
        }
        return apiKey
    }
    
    func translateText(_ text: String, source: String, target: String, apiKeyFileName: String = "Env", completion: @escaping (Result<TranslationResponse, Errors>) -> Void) {
        isLoading = true
        
        do {
            let apiKey = try getAPIKey(fromFileNamed: apiKeyFileName)

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
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw Errors.networkError
                    }
                    switch httpResponse.statusCode {
                    case 200:
                        return data
                    case 400:
                        throw Errors.invalidParameters
                    default:
                        throw Errors.networkError
                    }
                }
                .mapError { error -> Errors in
                    if let Errors = error as? Errors {
                        self.requestError = Errors
                        return self.requestError!
                    } else {
                        return Errors.networkError
                    }
                }
                .decode(type: TranslationResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { response in
                    self.translationData = response
                    self.translatedText = response.data.translations.first?.translatedText ?? ""
                    
                    self.isLoading = false
                    self.isFailure = false
                
                    completion(.success(self.translationData))
                })
               
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.requestError != nil {
                    completion(.failure(self.requestError!))
                } else if self.isFailure == true {
                    completion(.failure(Errors.networkError))
                }
            }
        } catch {
            completion(.failure(error as! Errors))
        }
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

