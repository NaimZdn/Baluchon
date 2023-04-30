//
//  ConverterViewModel.swift
//  Baluchon
//
//  Created by Zidouni on 24/04/2023.
//

import Foundation
import Combine

class ConverterViewModel: ObservableObject {
    @Published var baseCurrencyCode = ""
    @Published var convertCurrencyCode = ""
    @Published var exchangeRate = 0.0
    @Published var exchangeRateString = ""
    @Published var amountConverted = ""
    @Published var exchangeRateAvailable = false
    @Published var exchangeRates: [String: String] = [:]
    
    private var cancellable: AnyCancellable?
    private var currencyData: CurrencyResponse = .init(data: [:])
    
    init() {
        $exchangeRate
            .map { String(format: "%.2f", $0) }
            .assign(to: &$exchangeRateString)
    }
    
    func convertAmount(from baseCurrency: String, to convertCurrency: String) {
        if exchangeRates["\(baseCurrency) to \(convertCurrency)"] != nil {
            return
        }
        
        guard let envPath = Bundle.main.path(forResource: "Env", ofType: "plist"),
              let env = NSDictionary(contentsOfFile: envPath),
              let apiKey = env["CONVERTER_API_KEY"] as? String else {
            return
        }
        
        let url = URL(string: "https://api.currencyapi.com/v3/latest?apikey=\(apiKey)&base_currency=\(baseCurrency)&currencies=\(convertCurrency)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
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
                    self.baseCurrencyCode = baseCurrency
                    self.convertCurrencyCode = response.data[convertCurrency]?.code ?? ""
                    self.exchangeRate = convertedValue
                    self.exchangeRateAvailable = true

                }
            })
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

