//
//  WidgetDaily.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct WidgetDaily: View {
    @Binding var icon: String
    @Binding var temperature: Double
    @Binding var localTime: String
    @Binding var hour: String
    var isNight: Bool
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(localTime)")
                    .font(.widgetsDailyDate)
                    .foregroundColor(isNight ? Color.widgetTextDark : Color.widgetTextLight)
                
                Text("\(hour)")
                    .font(.widgetsDailyHours)
                    .foregroundColor(isNight ? Color.placeholderDark : Color.placeholderLight)
                    .padding(.bottom, 20)
                
                Text("\(String(format: "%.0f", temperature))°")
                    .font(.widgetsDailyDegree)
                    .foregroundColor(isNight ? Color.placeholderDark : Color.placeholderLight)
            }
            Spacer()
            Image("\(icon)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 115)
        }
        .frame(maxWidth: .infinity)
        .padding(25)
        .background(
            isNight ? Color.gradientDark : Color.gradientLight,
            in: RoundedRectangle(
                cornerRadius: 25,
                style: .continuous))
        .padding(.bottom, 15)
    }
}

struct WidgetDaily_Previews: PreviewProvider {
    @State static var icon = "sunny"
    @State static var temperature = 9.0
    @State static var localTime = "Lundi 24 avril"
    @State static var hour = "7:56"
    
    static var previews: some View {
        WidgetDaily(icon: $icon, temperature: $temperature, localTime: $localTime, hour: $hour, isNight: true)
    }
}
