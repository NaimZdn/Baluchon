//
//  WeatherView.swift
//  Baluchon
//
//  Created by Zidouni on 27/04/2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    private let cities = CurrentLocation.allCases
    @State private var selectedTabIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTabIndex) {
                ForEach(cities.indices, id: \.self) { index in
                    ZStack {
                        WeatherCity(city: cities[index].rawValue, country: cities[index].countryName)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            HStack(spacing: 10) {
                ForEach(cities.indices, id: \.self) { index in
                    Circle()
                        .foregroundColor(selectedTabIndex == index ? .primaryColor : .toggleColor)
                        .frame(width: 10, height: 10)
                }
            }
        }
        .background(Color.backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
