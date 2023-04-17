//
//  TranslationView.swift
//  Baluchon
//
//  Created by Zidouni on 03/04/2023.
//

import SwiftUI

struct TranslationView: View {
    @State private var textInput = ""
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TranslationButton(text: "French", image: "french")
                    Image(systemName: "arrow.left.arrow.right")
                        .foregroundColor(Color.iconLight)
                        .font(.system(size: 15))
                    
                    TranslationButton(text: "English (US)", image: "usa")
                }
                .padding(.bottom, 20)
                
                TranslationTextField(lang: "French")
                TranslationTextField(lang: "English")
            }
        }
        .padding(20)
        .background(Color.backgroundLight)
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
        
        
    }
}

