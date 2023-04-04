//
//  Style.swift
//  Baluchon
//
//  Created by Zidouni on 03/04/2023.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    public static let background = Color(hex: 0xFAFAFA)
    public static let primary = Color(hex: 0xC0C02C)
    public static let secondary = Color(hex: 0xF2E3D1)
    public static let title = Color(hex: 0x000000)
    public static let icon = Color(hex: 0xFFFFFF, alpha: 0.3)
    public static let separation = Color(hex: 0x000000, alpha: 0.1)
    public static let toggle = Color(hex: 0xD9D9D9)
    
    public static let gradientLight = LinearGradient(colors: [Color(hex: 0xF2E3D1), Color(hex: 0xEBD0B9)], startPoint: .bottomLeading, endPoint: .topTrailing)
    public static let gradientDark = LinearGradient(colors: [Color(hex: 0x2E335A), Color(hex: 0x1C1B33)], startPoint: .topLeading, endPoint: .bottomTrailing)
    
}

extension Font {
    
    // Font Declaration
    
    static func fontNexaRegular(_ size: CGFloat) -> Font {
        return Font.custom("Nexa-Regular", size: size)
    }
        
    static func fontNexaBold(_ size: CGFloat) -> Font {
        return Font.custom("Nexa-Bold", size: size)
    }
    
    static func fontNexaXBold(_ size: CGFloat) -> Font {
        return Font.custom("Nexa-XBold", size: size)
    }
    
    // Default Fonts
    
    static var defaultTertiaryText: Font {
        return fontNexaRegular(13)
    }
    
    static var defaultSecondaryText: Font {
        return fontNexaRegular(15)
    }
    
    static var defaultBody: Font {
        return fontNexaRegular(16)
    }
    
    static var defaultButtonCaption: Font {
        return fontNexaRegular(18)
    }
    
    static var defaultChangeAmount: Font {
        return fontNexaRegular(28)
    }
    
    static var defaultTitle2: Font {
        return fontNexaXBold(20)
    }
    
    static var defaultTitle1: Font {
        return fontNexaBold(32)
    }
    
    // Widgets Fonts
    
    static var widgetsHourlyHours: Font {
        return fontNexaXBold(13)
    }
    
    static var widgetsHourlyDegree: Font {
        return fontNexaXBold(28)
    }
    
    static var widgetsWeeklyHours: Font {
        return fontNexaXBold(13)
    }
    
    static var widgetsWeeklyMinDegree: Font {
        return fontNexaXBold(30)
    }
    
    static var widgetsWeeklyMaxDegree: Font {
        return fontNexaXBold(40)
    }
    
    static var widgetsDailyHours: Font {
        return fontNexaXBold(13)
    }
    
    static var widgetsDailyDate: Font {
        return fontNexaXBold(15)
    }
    
    static var widgetsDailyDegree: Font {
        return fontNexaXBold(60)
    }
    
    
    
}


