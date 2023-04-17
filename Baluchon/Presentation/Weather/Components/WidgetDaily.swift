//
//  WidgetDaily.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct WidgetDaily: View {
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 5) {
                Text("Mardi 11 avril")
                    .font(.widgetsDailyDate)
                    .foregroundColor(.widgetTextLight)
                
                Text("9:50")
                    .font(.widgetsDailyHours)
                    .foregroundColor(.placeholderLight)
                    .padding(.bottom, 20)
                
                Text("9°")
                    .font(.widgetsDailyDegree)
                    .foregroundColor(.placeholderLight)
            }
            
            Spacer()
            Image("cloudy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: 115)
        }
        .frame(maxWidth: .infinity)
        .padding(25)
        .background(
            Color.gradientLight,
            in: RoundedRectangle(
                cornerRadius: 25,
                style: .continuous))
        .padding(.bottom, 15)
    }
}

struct WidgetDaily_Previews: PreviewProvider {
    static var previews: some View {
        WidgetDaily()
    }
}
