//
//  WidgetWeekly.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct WidgetWeekly: View {
    var date: String
    var maxTemp: Double
    var minTemp: Double
    var isNight: Bool
    var weatherIcon: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(date)")
                    .font(.widgetsWeeklyHours)
                    .foregroundColor(isNight ? Color.widgetTextDark : Color.widgetTextLight)
                
                Text("\(String(format: "%.0f", maxTemp))°\(Text("/\(String(format: "%.0f", minTemp))°").font(.widgetsWeeklyMinDegree).foregroundColor(isNight ? Color.widgetMinDegreeDark : Color.widgetMinDegreeLight).baselineOffset(3))")
                    .font(.widgetsWeeklyMaxDegree)
                    .foregroundColor(isNight ? Color.placeholderDark : Color.placeholderLight)
               
            }
            Spacer()
            Image("\(weatherIcon)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
            
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .background(
            isNight ? Color.gradientDark : Color.gradientLight,
            in: RoundedRectangle(
                cornerRadius: 20,
                style: .continuous))
        .padding(.bottom, 10)
    }
}

struct WidgetWeekly_Previews: PreviewProvider {
    static var previews: some View {
        WidgetWeekly(date: "Lundi 24 avril", maxTemp: 12.0, minTemp: 25.6, isNight: false, weatherIcon: "Cloudy")
    }
}
