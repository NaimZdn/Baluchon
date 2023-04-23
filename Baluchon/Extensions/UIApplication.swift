//
//  UIApplication.swift
//  Baluchon
//
//  Created by Zidouni on 23/04/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
