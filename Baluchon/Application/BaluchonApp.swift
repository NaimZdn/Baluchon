//
//  BaluchonApp.swift
//  Baluchon
//
//  Created by Zidouni on 03/04/2023.
//

import SwiftUI

@main
struct BaluchonApp: App {
    @ObservedObject var theme = Theme()
    @State var isShowingLaunchingScreen = true
    @State var opacity = 1.0
    
    var body: some Scene {
        WindowGroup {
            if isShowingLaunchingScreen {
                LaunchScreenView()
                    .preferredColorScheme(theme.isDarkMode ? .dark : .light)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.1) {
                            self.isShowingLaunchingScreen = false
                        }
                    }
            } else {
                TabBarView()
                    .preferredColorScheme(theme.isDarkMode ? .dark : .light)
                    .environmentObject(theme)
            }
        }
    }
}

class Theme: ObservableObject {
    @Published var isDarkMode: Bool =  false
    
    init(){
        updateMode()
        Timer.scheduledTimer(withTimeInterval: 3_600, repeats: true) { _ in
            self.updateMode()
        }
    }
    
    private func updateMode() {
        let hour = Calendar.current.component(.hour, from: Date())
        isDarkMode = hour >= 21 || hour < 7
        
    }
}
