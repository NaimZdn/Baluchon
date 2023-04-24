//
//  ConverterView.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct ConverterView: View {
    @State var amount = 0.0
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Money Converter")
                    .font(.defaultTitle1)
                    .foregroundColor(.textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 39)
                
                CurrencyInput(currencyAmount: "0.0", currencyIcon: "$", currencyText: "USD")
                
                HStack(spacing: 0) {
                    Circle()
                        .foregroundColor(.primaryColor)
                        .frame(maxWidth: 6, maxHeight: 6)
                    
                    Rectangle()
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(Color.separationColor)
                    
                    Circle()
                        .foregroundColor(.primaryColor)
                        .frame(maxWidth: 6, maxHeight: 6)
                    
                }
                .padding(.vertical, 20)
                
                CurrencyInput(currencyAmount: "0.0", currencyIcon: "€", currencyText: "EUR")
            }
            .padding()
            Spacer()
            
        }
        .background(Color.backgroundColor)
    }
    
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
