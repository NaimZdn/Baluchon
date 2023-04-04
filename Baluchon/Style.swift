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


