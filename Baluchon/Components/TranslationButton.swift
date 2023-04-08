//
//  Components.swift
//  Baluchon
//
//  Created by Zidouni on 06/04/2023.
//

import SwiftUI

struct TranslationButton: View {
    var text = "French"
    var image = "french"
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(image)
                .resizable()
                .frame(width: 24, height:24)
            Text(text)
                .font(.defaultSecondaryText)
                .foregroundColor(.black)
                .baselineOffset(-7)
        }
        
        .frame(minWidth: 120, maxHeight: 24, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(
            Color.secondaryLight,
            in: RoundedRectangle(
                cornerRadius: 15,
                style: .continuous))
        
    }
}

struct TranslationButton_Previews: PreviewProvider {
    static var previews: some View {
        TranslationButton()
    }
}
