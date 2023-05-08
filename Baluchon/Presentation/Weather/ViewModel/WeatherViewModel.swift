//
//  WeatherViewModel.swift
//  Baluchon
//
//  Created by Zidouni on 26/04/2023.
//

import Foundation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var location = ""
    @Published var localTime = ""
    @Published var country = ""
    @Published var icon = ""
    @Published var hour = ""
    @Published var temperature = 0.0
    @Published var sunrise = ""
    @Published var sunset = ""
    @Published var dayList = [Forecastday]()
    @Published var colorMode = false
    @Published var widgetIcon = ""
    @Published var localTimeForWidget = ""

    private var cancellable: AnyCancellable?
    private var requestError: Errors? = nil 
    
    private func getAPIKey(fromFileNamed fileName: String) throws -> String {
        guard let envPath = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let env = NSDictionary(contentsOfFile: envPath),
              let apiKey = env["WEATHER_API_KEY"] as? String else {
            throw Errors.apiKeyNotFound
        }
        return apiKey
    }
    
    func getWeather(for location: String, apiKeyFileName: String = "Env", completion: @escaping (Result<WeatherResponse, Errors>) -> Void) {
        
        do {
            let apiKey = try getAPIKey(fromFileNamed: apiKeyFileName)
            
            let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(location)&days=7")!
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            cancellable = URLSession.shared.dataTaskPublisher(for: request)
                .tryMap{ (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw Errors.networkError
                    }
                    switch httpResponse.statusCode {
                    case 200:
                        return data
                    case 400:
                        throw Errors.invalidParameters
                    case 403:
                        throw Errors.unauthorizedAccess
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
                .decode(type: WeatherResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { response in
                    self.location = response.location.name
                    self.country = response.location.country
                    self.icon = response.current.condition.text
                    self.temperature = response.current.tempC
                    self.localTime = self.convertStringToDate(from: response.location.localtime)
                    self.hour = self.convertStringToHour(from: response.current.lastUpdated)
                    self.sunset = response.forecast.forecastday[0].astro.sunset
                    self.sunrise = response.forecast.forecastday[0].astro.sunrise
                    self.dayList = Array(response.forecast.forecastday.dropFirst())
                    self.colorMode = self.changeColorMode()
                    
                    completion(.success(response))
                    
                })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.requestError != nil {
                    completion(.failure(self.requestError!))
                }
            }
        } catch {
            completion(.failure(error as! Errors))
        }
        
    }
    
    func convertStringToDate(from string: String) -> String {
        let dateFormatterInput = DateFormatter()
        
        if string.count == 10 {
            dateFormatterInput.dateFormat = "yyyy-MM-dd"
        } else {
            dateFormatterInput.dateFormat = "yyyy-MM-dd HH:mm"
        }
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.locale = Locale(identifier: "fr_FR")
        dateFormatterOutput.dateFormat = "EEEE dd MMMM"
        
        let date = dateFormatterInput.date(from: string)
        
        guard date != nil else {
            return "We cannot convert this String to Date"
        }
        
        return dateFormatterOutput.string(from: date!).localizedCapitalized

    }
    
    func convertStringToHour(from string: String) -> String {
        let dateFormatterInput = DateFormatter()
        
        if string.count == 8 {
            dateFormatterInput.dateFormat = "hh:mm a"
        } else {
            dateFormatterInput.dateFormat = "yyyy-MM-dd HH:mm"
        }
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "HH:mm"
        
        let date = dateFormatterInput.date(from: string)
        
        guard date != nil else {
            return "We cannot convert this String to Date"
        }
        
        return dateFormatterOutput.string(from: date!)
        
    }
    
    func changeColorMode() -> Bool {
        let cleanedLocalTime = hour.replacingOccurrences(of: ":", with: ".")
        let localTimeDouble = Double(cleanedLocalTime)!
        
        let sunsetHourDouble = Double(convertStringToHour(from: sunset).replacingOccurrences(of: ":", with: "."))!
        let sunriseHourDouble = Double(convertStringToHour(from: sunrise).replacingOccurrences(of: ":", with: "."))!
        
        if localTimeDouble >= sunsetHourDouble || localTimeDouble < sunriseHourDouble {
            return true
        } else {
            return false
        }
    }
}
