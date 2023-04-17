//
//  CurrencyButton.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct CurrencyButton: View {
    var currencyIcon: String
    
    var body: some View {
        Text(currencyIcon)
            .font(.defaultMoney)
            .foregroundColor(.primaryLight)
            .frame(width: 50, height: 50)
            .background(
                Color.secondaryLight,
                in: RoundedRectangle(
                    cornerRadius: 15,
                    style: .continuous))
            .baselineOffset(-4)
    }
}

struct CurrencyButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyButton(currencyIcon: "$")
    }
}
