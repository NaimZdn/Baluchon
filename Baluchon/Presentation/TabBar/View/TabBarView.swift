//
//  TabBarButton.swift
//  Baluchon
//
//  Created by Zidouni on 17/04/2023.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab: TabBar = .converter
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                if selectedTab == .converter {
                    ConverterView()
                } else if selectedTab == .translation {
                    TranslationView()
                } else {
                    WeatherView()
                }
            }
            Spacer()
            CustomTabBar(selectedTab: $selectedTab)
        }
        .background(Color.backgroundLight)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
