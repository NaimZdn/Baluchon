//
//  TranslationTextField.swift
//  Baluchon
//
//  Created by Zidouni on 08/04/2023.
//

import SwiftUI

struct TranslationTextField: View {
    @ObservedObject var viewModel = TranslationViewModel()
    @FocusState private var nameIsFocused: Bool
    
    @Binding var textInput: String
    
    @State private var isShowingView = false
    @State var text = ""
    
    var isDisabled: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                HStack(alignment: .top) {
                    if #available(iOS 16.0, *) {
                        TextField("Écrivez ou collez votre texte ici...", text: $textInput, axis: .vertical)
                            .onTapGesture {
                                endTextEditing()
                                
                            }
                            .disableAutocorrection(true)
                            .font(.defaultBody)
                            .focused($nameIsFocused)
                            .toolbar {
                                if !isDisabled {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button {
                                            nameIsFocused = false
                                            endTextEditing()
                                        } label: {
                                            Image(systemName: "keyboard.chevron.compact.down")
                                                .foregroundColor(Color.iconColor)
                                            
                                        }
                                    }
                                }
                            }
                    } else {
                        TextEditor(text: $textInput)
                            .colorMultiply(.clear)
                        
                            .onTapGesture {
                                endTextEditing()
                                
                            }
                            .disableAutocorrection(true)
                            .disabled(isDisabled)
                            .font(.defaultBody)
                            .focused($nameIsFocused)
                    
                    }
                    
                    if !textInput.isEmpty && !isDisabled {
                        Button {
                            textInput = ""
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 15))
                                .foregroundColor(Color.iconColor)
                            
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Rectangle()
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(Color.separationColor)
                    
                    if isDisabled || textInput.isEmpty {
                        HStack() {
                            if !isDisabled && textInput.isEmpty {
                                Button {
                                    textInput = viewModel.pasteToClipBoard()
                                    
                                } label: {
                                    Text("Coller")
                                        .baselineOffset(-3)
                                        .font(.defaultBody)
                                        .foregroundColor(Color.iconColor)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                .stroke(Color.iconColor)
                                        )
                                }
                            }
                            Spacer()
                            HStack(spacing: 15) {
                                Button {
                                    isShowingView = viewModel.copyToClipboard(text: textInput)
                                    
                                } label: {
                                    if !textInput.isEmpty {
                                        if isShowingView {
                                            Text("Copié !")
                                                .foregroundColor(Color.placeholderColor)
                                                .onAppear {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                        withAnimation(.easeInOut(duration: 0.3)) {
                                                            isShowingView = false
                                                            
                                                        }
                                                    }
                                                }
                                        } else {
                                            Image("copy")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(Color.iconColor)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                    }
                }
            }
            .frame(minWidth: 120, minHeight: 100, maxHeight: 100 , alignment: .topLeading)
            .padding(.top, isDisabled ? 20 : 5)
        }
    }
}

struct TranslationTextField_Previews: PreviewProvider {
    
    @State static var textInput = ""
    
    static var previews: some View {
        TranslationTextField(textInput: $textInput, isDisabled: false)
    }
}
