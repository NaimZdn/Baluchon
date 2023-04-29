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
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
            .preferredColorScheme(theme.isDarkMode ? .dark : .light)
            .environmentObject(theme)
        }
    }
}

class Theme: ObservableObject {
    @Published var isDarkMode: Bool =  false
    
    init(){
        updateMode()
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.updateMode()
        }
    }
    
    private func updateMode() {
        let hour = Calendar.current.component(.hour, from: Date())
        isDarkMode = hour >= 20 || hour < 6

    }
}
