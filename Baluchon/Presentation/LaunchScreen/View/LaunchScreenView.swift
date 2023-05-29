//
//  LaunchScreenView.swift
//  Baluchon
//
//  Created by Zidouni on 01/05/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var opacity: Double = 1.0
    
    var body: some View {
        VStack(alignment: .center) {
            LottieView(fileName: "baluchon")
                .scaleEffect(0.37)
                .padding(.trailing, 20)
                .padding(.bottom, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundAnimationColor)
        .opacity(opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    opacity = 0
                }
            }
        }
    }
}

struct LaunchingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
