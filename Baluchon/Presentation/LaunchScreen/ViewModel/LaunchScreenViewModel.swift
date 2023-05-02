//
//  LaunchScreenViewModel.swift
//  Baluchon
//
//  Created by Zidouni on 02/05/2023.
//

import SwiftUI
import Foundation
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
