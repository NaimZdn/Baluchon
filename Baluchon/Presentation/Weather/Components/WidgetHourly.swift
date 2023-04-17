//
//  WidgetHourly.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct WidgetHourly: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("10:50")
                .font(.widgetsHourlyHours)
                .foregroundColor(.placeholderLight)
            
            Image("cloudy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: 50)
            
            Text("10°")
                .font(.widgetsHourlyDegree)
                .foregroundColor(.placeholderLight)
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 13)
        .background(
            Color.gradientLight,
            in: RoundedRectangle(
                cornerRadius: 25,
                style: .continuous))
        .padding(.bottom, 15)    }
}

struct WidgetHourly_Previews: PreviewProvider {
    static var previews: some View {
        WidgetHourly()
    }
}
