//
//  CurrencyInput.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct CurrencyInput: View {
    @ObservedObject private var viewModel = ConverterViewModel()
    @FocusState private var amountIsFocused: Bool
    @Binding var currencyAmount: String
    
    var isDisabled: Bool
    var currencyIcon: String
    var currencyText: String
    
    var body: some View {
        HStack {
            HStack() {
                CurrencyButton(currencyIcon: currencyIcon)
                
                Text(currencyText)
                    .font(.defaultButtonCaption)
                    .foregroundColor(.placeholderColor)
                    .baselineOffset(-4)
                
            }
            HStack() {
                TextField("", text: $currencyAmount, prompt: Text("0.00").foregroundColor(.placeholderColor))
                    .onChange(of: currencyAmount, perform: { input in
                        currencyAmount = viewModel.validateCurrencyInput(input)
                    })
                    .disabled(isDisabled)
                    .keyboardType(.decimalPad)
                    .font(.defaultChangeAmount)
                    .foregroundColor(.textColor)
                    .multilineTextAlignment(.trailing)
                    .baselineOffset(-4)
                    .toolbar {
                        if !isDisabled {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button {
                                    amountIsFocused = false
                                    endTextEditing()
                                } label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                        .foregroundColor(Color.iconColor)
                                    
                                }
                            }
                            
                        }
                    }
            }
        }
    }
}

struct CurrencyInput_Previews: PreviewProvider {
    @State static var amount = "1.98"
    
    static var previews: some View {
        CurrencyInput(currencyAmount: $amount, isDisabled: true, currencyIcon: "$", currencyText: "USD")
            .padding()
            .background(Color.backgroundColor)
    }
}
