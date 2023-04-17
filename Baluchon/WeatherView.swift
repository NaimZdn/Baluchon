//
//  WeatherView.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Text("Paris, \(Text("France").foregroundColor(.placeholderLight))")
                .font(.defaultTitle2)
                .padding(.bottom, 10)
            
            ScrollView() {
                VStack {
                    WidgetDaily()
                    WidgetHourly()
                    WidgetWeekly()
                }
            }
            .padding()
        }
        .background(Color.backgroundLight)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
	
