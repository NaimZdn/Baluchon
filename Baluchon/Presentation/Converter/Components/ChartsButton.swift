//
//  ChartsButton.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct ChartsButton: View {
    var date: String
    
    var body: some View {
        
        Text(date)
            .font(.defaultSecondaryText)
            .foregroundColor(.primaryLight)
            .padding(.horizontal, 16)
            .padding(.vertical, 7)
            .background(
                Color.secondaryLight,
                in: RoundedRectangle(
                    cornerRadius: 15,
                    style: .continuous))
            .baselineOffset(-3)
    }
}

struct ChartsButton_Previews: PreviewProvider {
    static var previews: some View {
        ChartsButton(date: "Day")
    }
}
