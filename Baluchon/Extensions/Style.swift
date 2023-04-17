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
            .sRGB	,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    public static let backgroundLight = Color(hex: 0xFAFAFA)
    public static let primaryLight = Color(hex: 0xC0602C)
    public static let secondaryLight = Color(hex: 0xF2E3D1)
    public static let titleLight = Color(hex: 0x000000)
    public static let iconLight = Color(hex: 0x000000, alpha: 0.3)
    public static let placeholderLight = Color(hex: 0x000000, alpha: 0.5)
    public static let separation = Color(hex: 0x000000, alpha: 0.1)
    public static let toggle = Color(hex: 0xD9D9D9)
    public static let widgetTextLight = Color(hex: 0x000000, alpha: 0.7)
    
    public static let gradientLight = LinearGradient(colors: [Color(hex: 0xEBD0B9), Color(hex: 0xF2E3D1)], startPoint: .bottomLeading, endPoint: .topTrailing)
    public static let gradientDark = LinearGradient(colors: [Color(hex: 0x2E335A), Color(hex: 0x1C1B33)], startPoint: .topLeading, endPoint: .bottomTrailing)
    
}

extension Font {
    
    // Font Declaration
    
    static func fontRegular(_ size: CGFloat) -> Font {
        return Font.custom("Nexa-Regular", size: size)
    }
        
    static func fontBold(_ size: CGFloat) -> Font {
        return Font.custom("Nexa-Bold", size: size)
    }
    
    static func fontXBold(_ size: CGFloat) -> Font {
        return Font.custom("Nexa-XBold", size: size)
    }
    
    // Default Fonts
    
    static var defaultTertiaryText: Font {
        return fontRegular(13)
    }
    
    static var defaultSecondaryText: Font {
        return fontBold(15)
    }
    
    static var defaultBody: Font {
        return fontRegular(16)
    }
    
    static var defaultButtonCaption: Font {
        return fontRegular(18)
    }
    
    static var defaultChangeAmount: Font {
        return fontRegular(28)
    }
    
    static var defaultTitle2: Font {
        return fontXBold(20)
    }
    
    static var defaultMoney: Font {
        return fontBold(24)
    }
    
    static var defaultTitle1: Font {
        return fontBold(32)
    }
    
    // Widgets Fonts
    
    static var widgetsHourlyHours: Font {
        return fontXBold(13)
    }
    
    static var widgetsHourlyDegree: Font {
        return fontXBold(28)
    }
    
    static var widgetsWeeklyHours: Font {
        return fontXBold(13)
    }
    
    static var widgetsWeeklyMinDegree: Font {
        return fontXBold(30)
    }
    
    static var widgetsWeeklyMaxDegree: Font {
        return fontXBold(40)
    }
    
    static var widgetsDailyHours: Font {
        return fontXBold(13)
    }
    
    static var widgetsDailyDate: Font {
        return fontXBold(15)
    }
    
    static var widgetsDailyDegree: Font {
        return fontXBold(60)
    }
    
    
    
}


