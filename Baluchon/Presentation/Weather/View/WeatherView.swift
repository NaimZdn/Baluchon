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
            Text("Paris, \(Text("France").foregroundColor(.placeholderColor))")
                .font(.defaultTitle2)
                .foregroundColor(Color.textColor)
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
        .background(Color.backgroundColor)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
	
