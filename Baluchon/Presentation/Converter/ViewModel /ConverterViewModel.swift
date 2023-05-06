//
//  ConverterViewModel.swift
//  Baluchon
//
//  Created by Zidouni on 24/04/2023.
//

import Foundation
import Combine

class ConverterViewModel: ObservableObject {
    @Published var exchangeRate = 0.0
    @Published var exchangeRateString = ""
    @Published var amountConverted = ""
    @Published var exchangeRateAvailable = false
    @Published var exchangeRates: [String: String] = [:]
    
    private var cancellable: AnyCancellable?
    private var currencyData: CurrencyResponse = .init(data: [:])
    private var requestError: Errors? = nil
    
    init() {
        $exchangeRate
            .map { String(format: "%.2f", $0) }
            .assign(to: &$exchangeRateString)
    }
    
    private func getAPIKey(fromFileNamed fileName: String) throws -> String {
        guard let envPath = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let env = NSDictionary(contentsOfFile: envPath),
              let apiKey = env["CONVERTER_API_KEY"] as? String else {
            throw Errors.apiKeyNotFound
        }
        return apiKey
    }
    
    func getExchangeRate(from baseCurrency: String, to convertCurrency: String, apiKeyFileName: String = "Env", completion: @escaping (Result<CurrencyResponse, Errors>) -> Void) {
        
        if exchangeRates["\(baseCurrency) to \(convertCurrency)"] != nil {
            return completion(.failure(Errors.exchangeRateAlreadyAvailable))
        }
        
        do {
            let apiKey = try getAPIKey(fromFileNamed: apiKeyFileName)
            
            let url = URL(string: "https://api.currencyapi.com/v3/latest?apikey=\(apiKey)&base_currency=\(baseCurrency)&currencies=\(convertCurrency)")!
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            cancellable = URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw Errors.networkError
                    }
                    switch httpResponse.statusCode {
                    case 200:
                        return data
                    case 401:
                        throw Errors.unauthorizedAccess
                    case 422:
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
                .decode(type: CurrencyResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                        
                    }
                }, receiveValue: { response in
                    if let convertedValue = response.data[convertCurrency]?.value {
                        self.exchangeRates["\(baseCurrency) to \(convertCurrency)"] = String(format: "%.2f",convertedValue)
                        self.exchangeRates["\(convertCurrency) to \(baseCurrency)"] = String(format: "%.2f",1 / convertedValue)
                        
                        self.currencyData = response
                        self.exchangeRate = convertedValue
                        self.exchangeRateAvailable = true               
                    }
                })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.requestError != nil {
                    completion(.failure(self.requestError!))
                } else {
                    completion(.success(self.currencyData))
                }
            }
        } catch {
            completion(.failure(error as! Errors))
        }
    }
    
    func calculConvertedAmount(amount: String, rate: String) -> String{
        let amountDouble = Double(amount) ?? 0.0
        let rateToDouble = Double(rate)
        let exchangeRate = amountDouble * rateToDouble!
        
        return String(format: "%.2f", exchangeRate)
    }
    
    func validateCurrencyInput(_ input: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789,.")
        let filteredInput = input.filter { allowedCharacters.contains(UnicodeScalar(String($0))!) }
            .replacingOccurrences(of: ",", with: ".")
        
        var formattedInput = filteredInput
        if formattedInput.first == "." {
            formattedInput = "0" + formattedInput
        }
        
        let components = formattedInput.components(separatedBy: ".")
        if components.count > 2 {
            formattedInput = components[0] + "." + components[1].prefix(2)
        }
        
        return formattedInput
    }
}

