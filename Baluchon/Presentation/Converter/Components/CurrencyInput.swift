//
//  CurrencyInput.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct CurrencyInput: View {
    
    @State var currencyAmount: String
    var currencyIcon: String
    var currencyText: String
    
    var body: some View {
        HStack {
            HStack() {
                CurrencyButton(currencyIcon: currencyIcon)
                
                Text(currencyText)
                    .font(.defaultButtonCaption)
                    .foregroundColor(.placeholderLight)
                    .baselineOffset(-4)
                
            }
            HStack() {
                TextField("", text: $currencyAmount)
                    .font(.defaultChangeAmount)
                    .multilineTextAlignment(.trailing)
                    .baselineOffset(-4)
            
            }
        }
    }
}

struct CurrencyInput_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyInput(currencyAmount: "0.0", currencyIcon: "$", currencyText: "USD")
    }
}
