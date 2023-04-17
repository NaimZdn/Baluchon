//
//  ConverterView.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct ConverterView: View {
    @State var amount = "0.0"
    private let dateOptions =  ["Day", "Week", "Month", "Years"]
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Money Converter")
                    .font(.defaultTitle1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 39)
                
                CurrencyInput(currencyAmount: "0.0", currencyIcon: "$", currencyText: "USD")
                
                HStack(spacing: 0) {
                    Circle()
                        .foregroundColor(.primaryLight)
                        .frame(maxWidth: 6, maxHeight: 6)
                    
                    Rectangle()
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(Color.separation)
                    
                    Circle()
                        .foregroundColor(.primaryLight)
                        .frame(maxWidth: 6, maxHeight: 6)
                    
                }
                .padding(.vertical, 20)
                
                CurrencyInput(currencyAmount: "0.0", currencyIcon: "€", currencyText: "EUR")
            }
            .padding()
            
            VStack(spacing: 0) {
                Text("Charts")
                    .font(.defaultTitle1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                
                HStack(spacing: 20) {
                    CurrencyButton(currencyIcon: "$")
                    CurrencyButton(currencyIcon: "€")
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(dateOptions, id: \.self) { date in
                        createChartsButton(date: date)
                    }
                }
            }
            .padding()
            
        }
    }
    
    func createChartsButton(date: String) -> ChartsButton {
        ChartsButton(date: date)
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
