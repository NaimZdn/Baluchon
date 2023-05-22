//
//  WeatherCity.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct WeatherCity: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var translationViewModel = TranslationViewModel()
    @State private var isShowingSecondView = false
    
    var city: String
    var country: String
    
    var body: some View {
        VStack {
            VStack {
                if viewModel.isLoading {
                    Color.backgroundColor
                        .ignoresSafeArea()
                    ProgressView()
                        .frame(width: 400, height: 750, alignment: .center)
                        .scaleEffect(2)
                    
                } else {
                    Text("\(viewModel.location), \(Text("\(country)").foregroundColor(.placeholderColor))")
                        .font(.defaultTitle2)
                        .foregroundColor(Color.textColor)
                        .padding(.bottom, 10)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            WidgetDaily(icon: $viewModel.icon, temperature: $viewModel.temperature, localTime: $viewModel.localTime, hour: $viewModel.hour, isNight: viewModel.colorMode)
                            
                            ForEach(viewModel.dayList, id: \.date) { day in
                                let dateConvert = viewModel.convertStringToDate(from: day.date)
                                WidgetWeekly(date: dateConvert, maxTemp: day.day.maxtempC, minTemp: day.day.mintempC, isNight: viewModel.changeColorMode(), weatherIcon: day.day.condition.text)
                                
                            }
                        }
                    }
                    .refreshable {
                        print("Hello")
                            viewModel.getWeather(for: "\(city)") { result in
                                switch result {
                                case .success(let response):
                                    self.viewModel.country = response.location.country
                                case .failure(let error):
                                    print("Voici l'erreur weather : \(error)")
                                }
                            }
                    }
                }
            }
        }
        .padding()
        .background(Color.backgroundColor)
        .onAppear {
            if viewModel.hour == "" {
                viewModel.getWeather(for: "\(city)") { result in
                    switch result {
                    case .success(let response):
                        WeatherView().isLoading = false
                        self.viewModel.country = response.location.country
                    case .failure(let error):
                        print("Error: \(error.errorDescription)")
                    }
                }
            }
        }
    }
}

struct WeatherViewParis_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCity(city: "Paris", country: "France")
    }
}

