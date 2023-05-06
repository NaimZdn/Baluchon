//
//  TranslationView.swift
//  Baluchon
//
//  Created by Zidouni on 03/04/2023.
//

import SwiftUI
import Combine

struct TranslationView: View {
    @ObservedObject var viewModel = TranslationViewModel()
    @State private var isReversed = false
    @State private var textToTranslate = ""
    @State private var translatedString = ""
    @State private var isDisabled = true
    
    private var englishId: String {
        isReversed ? "en" : "fr"
    }
    
    private var frenchId : String {
        isReversed ? "fr" : "en"
    }
    
    var body: some View {
        VStack  {
            HStack {
                TranslationButton(text: "\(isReversed ? "English (US)" : "French")",
                                  image: "\(isReversed ? "usa" : "french")",
                                  id: englishId)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isReversed.toggle()
                        translatedString = viewModel.translatedText
                        textToTranslate = translatedString
                        
                    }
                    
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .foregroundColor(Color.iconColor)
                        .font(.system(size: 15))
                }
                
                TranslationButton(text: "\(isReversed ? "French" : "English (US)")",
                                  image: "\(isReversed ? "french" : "usa")",
                                  id: frenchId)
                
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
            
            VStack {
                TranslationTextField(textInput: $textToTranslate, isDisabled: false)
                
                if !isDisabled {
                    TranslationTextField(textInput: $viewModel.translatedText, isDisabled: true)
                }
            }
            Spacer()
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .onReceive(Just(textToTranslate)) { text in
            viewModel.translateText(text, source: isReversed ? "en" : "fr", target: isReversed ? "fr" : "en") { result in
                switch result {
                case .success:
                    print("Success")
                case .failure(let error):
                    print("Error: \(error.errorDescription)")
                }
                
            }
            
            if viewModel.translatedText.isEmpty {
                isDisabled = true
            } else {
                isDisabled = false
            }
        }
        .background(Color.backgroundColor)
    }
}


struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
        
        
    }
}

