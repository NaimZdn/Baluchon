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
    @State private var convertedAmount = ""
    
    private var convertFrom : String {
        isReversed ? Currency.dollar.currency: Currency.euro.currency
    }
    
    private var convertTo : String {
        isReversed ? Currency.euro.currency: Currency.dollar.currency
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Color.backgroundColor
                    .ignoresSafeArea()
                ProgressView()
                    .frame(width: 400, height: 650, alignment: .center)
                    .scaleEffect(2) 
                
            } else {
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
                                convertedAmount = viewModel.calculConvertedAmount(amount: amount, rate: isValuesStrored ? viewModel.exchangeRates["\(convertFrom) to \(convertTo)"]! : viewModel.exchangeRateString)
                                
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
                            
                            convertedAmount = viewModel.calculConvertedAmount(amount: amount, rate: viewModel.exchangeRates["\(convertFrom) to \(convertTo)"]!)
                            
                            
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
                    
                    CurrencyInput(currencyAmount: $convertedAmount, isDisabled: true, currencyIcon: isReversed ? Currency.euro.rawValue : Currency.dollar.rawValue, currencyText: convertTo)
                }
                
                HStack{
                    Spacer()
                    
                    if #available(iOS 16.0, *) {
                        Text("1 \(convertFrom) = \(isValuesStrored ? viewModel.exchangeRates["\(convertFrom) to \(convertTo)"]! : viewModel.exchangeRateString) \(convertTo)")
                            .font(.defaultBody)
                            .fontWeight(.bold)
                            .foregroundColor(.secondaryColor)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.primaryColor, in:RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .baselineOffset(-2)
                    } else {
                        Text("1 \(convertFrom) = \(isValuesStrored ? viewModel.exchangeRates["\(convertFrom) to \(convertTo)"]! : viewModel.exchangeRateString) \(convertTo)")
                            .font(.defaultBody)
                            .fontWeight(.bold)
                            .foregroundColor(.secondaryColor)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .padding(.bottom, -2)
                            .background(Color.primaryColor, in:RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }       
                }
                Spacer()
                
            }
        }
        .padding(20)
        .background(Color.backgroundColor)
        .onAppear {
            viewModel.getExchangeRate(from: convertFrom, to: convertTo) { result in
                switch result {
                case .success:
                    print("Success")
                case .failure(let error):
                    print("Voici l'erreur weather : \(error)")
                   // print("Error: \(error.errorDescription)")
                }
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

@available(iOS 16.0, *)
struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
