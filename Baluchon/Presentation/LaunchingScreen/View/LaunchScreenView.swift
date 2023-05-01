//
//  LaunchScreenView.swift
//  Baluchon
//
//  Created by Zidouni on 01/05/2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationView = LottieAnimationView()

    var fileName: String

    func makeUIView(context: Context) -> UIView {
        animationView.backgroundColor = .clear
        animationView.animation = LottieAnimation.named(fileName)
        animationView.play()

        return animationView
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

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
