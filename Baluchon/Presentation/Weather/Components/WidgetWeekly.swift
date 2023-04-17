//
//  WidgetWeekly.swift
//  Baluchon
//
//  Created by Zidouni on 11/04/2023.
//

import SwiftUI

struct WidgetWeekly: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Mercredi 12 avril")
                    .font(.widgetsWeeklyHours)
                    .foregroundColor(Color.widgetTextLight)
                
                Text("18°\(Text("/10°").font(.widgetsWeeklyMinDegree).foregroundColor(.iconLight).baselineOffset(3))")
                    .font(.widgetsWeeklyMaxDegree)
                    .foregroundColor(.placeholderLight)
               
            }
            Spacer()
            
            Image("sunny")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: 60)
            
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .background(
            Color.gradientLight,
            in: RoundedRectangle(
                cornerRadius: 20,
                style: .continuous))
        .padding(.bottom, 15)
    }
}

struct WidgetWeekly_Previews: PreviewProvider {
    static var previews: some View {
        WidgetWeekly()
    }
}
