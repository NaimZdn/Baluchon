//
//  TranslationView.swift
//  Baluchon
//
//  Created by Zidouni on 03/04/2023.
//

import SwiftUI

struct TranslationView: View {
    @State private var textInput = ""
    @State private var isReversed = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TranslationButton(text: "\(isReversed ? "English (US)" : "French")",
                                      image: "\(isReversed ? "usa" : "french")")
                    Button {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isReversed.toggle()
                        }
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundColor(Color.iconColor)
                            .font(.system(size: 15))
                    }
                    TranslationButton(text: "\(isReversed ? "French" : "English (US)")",
                                      image: "\(isReversed ? "french" : "usa")")
 
                }
                .padding(.bottom, 20)
                
                TranslationTextField(lang: "\(isReversed ? "French" : "English")")
                TranslationTextField(lang: "\(isReversed ? "English" : "French")")
            }
        }
        .padding(20)
        .background(Color.backgroundColor)
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
        
        
    }
}

