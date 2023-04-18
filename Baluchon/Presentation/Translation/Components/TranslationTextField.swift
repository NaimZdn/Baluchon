//
//  TranslationTextField.swift
//  Baluchon
//
//  Created by Zidouni on 08/04/2023.
//

import SwiftUI

struct TranslationTextField: View {
    @State private var textInput = ""
    var lang = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Translate from \(Text(lang).foregroundColor(.primaryColor))")
                .font(.defaultButtonCaption)
                .foregroundColor(.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                TextField("Écrivez ou collez votre texte ici.", text: $textInput, axis: .vertical)
                    .font(.defaultBody)
                    
                    .padding([.horizontal, .top], 20)
                    .padding(.bottom, 20)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Rectangle()
                        .cornerRadius(10)
                        .frame(maxWidth: 313, maxHeight: 2)
                        .foregroundColor(Color.separationColor)
                    
                    HStack() {
                        Image("microphone")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.iconColor)
                        
                        Spacer()
                        HStack(spacing: 15) {
                            Image("copy")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.iconColor)
                            
                            Image("volume")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.iconColor)
                        }
                    }
                    .padding([.horizontal, .bottom], 20)
                    .padding(.top, 15)
                    
                }
            }
            .frame(minWidth: 120, minHeight: 235, maxHeight: 235, alignment: .topLeading)
            .background(
                Color.textFieldColor,
                in: RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous))
            .shadow(color: Color.separationColor, radius: 10, x: 0, y: 12 )
            
        }
        .padding(.bottom, 30)
        
    }
}

struct TranslationTextField_Previews: PreviewProvider {
    static var previews: some View {
        TranslationTextField()
            .padding()
            .background(Color.backgroundColor)
            
    }
}
