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
        ZStack {
            VStack {
                
                TabView(selection: $selectedTab) {
                    ConverterView()
                        .tag(TabBar.converter)
                    TranslationView()
                        .tag(TabBar.translation)
                    WeatherView()
                        .tag(TabBar.weather)
                }
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                
            }
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea(.keyboard)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
