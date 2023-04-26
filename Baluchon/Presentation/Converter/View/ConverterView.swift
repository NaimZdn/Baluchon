//
//  ConverterView.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI
import Combine

struct ConverterView: View {
    @StateObject var viewModel = ConverterViewModel()
    
    @State private var amount = ""
    @State private var isReversed = false
    @State private var isValuesStrored = false
    @State private var baseCurrency = ""
    @State private var convertCurrency = ""
    
    private var convertFrom : String {
        isReversed ? Currency.dollar.currency: Currency.euro.currency
    }
    
    private var convertTo : String {
        isReversed ? Currency.euro.currency: Currency.dollar.currency
    }

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Money Converter")
                    .font(.defaultTitle1)
                    .foregroundColor(.textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 39)
                
                CurrencyInput(currencyAmount: $amount, isDisabled: false, currencyIcon: isReversed ? Currency.dollar.rawValue : Currency.euro.rawValue, currencyText: convertFrom)
                    .onChange(of: amount) { newValue in
                        let filteredInput = viewModel.validateCurrencyInput(newValue)
                        amount = filteredInput
                       
                        if !amount.isEmpty {
                            viewModel.calculConvertedAmount(amount: amount, rate: isValuesStrored ? viewModel.exchangeRates["\(convertFrom) to \(convertTo)"]! : viewModel.exchangeRateString)
                           
                        }
                    }
                    
                
                HStack(spacing: 0) {
                    Circle()
                        .foregroundColor(.primaryColor)
                        .frame(minWidth: 6, maxWidth: 6, minHeight: 6, maxHeight: 6)
                    
                    Rectangle()
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(Color.separationColor)
                    
                    Button {
                        isReversed.toggle()
                        if !isValuesStrored {
                            isValuesStrored = true
                        }
                        
                        viewModel.calculConvertedAmount(amount: amount, rate: viewModel.exchangeRates["\(convertFrom) to \(convertTo)"]!)
                        

                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 20))
                            .foregroundColor(.iconColor)
                            .padding(.horizontal, 5)
                        
                    }
    
                    Rectangle()
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(Color.separationColor)
                    
                    Circle()
                        .foregroundColor(.primaryColor)
                        .frame(minWidth: 6, maxWidth: 6, minHeight: 6, maxHeight: 6)
                    
                }
                .padding(.vertical, 20)
                
                CurrencyInput(currencyAmount: $viewModel.amountConverted, isDisabled: true, currencyIcon: isReversed ? Currency.euro.rawValue : Currency.dollar.rawValue, currencyText: convertTo)
            }
            
            HStack{
                Spacer()
                Text("1 \(convertFrom) = \(isValuesStrored ? viewModel.exchangeRates["\(convertFrom) to \(convertTo)"]! : viewModel.exchangeRateString) \(convertTo)")
                    .font(.defaultBody)
                    .fontWeight(.bold)
                    .foregroundColor(.secondaryColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.primaryColor, in:RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .baselineOffset(-2)
            }
            Spacer()
        }
        .padding(20)
        .background(Color.backgroundColor)
        .onAppear {
            viewModel.convertAmount(from: convertFrom, to: convertTo)
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
}


struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
