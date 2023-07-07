//
//  TextColor.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import SwiftUI


extension Color {
    struct TextColor {
        let primary: Color = .init("text_primary_color")
        let secondary: Color = .init("text_secondary_color")
        let opacity: Color = .init("text_opacity_color")
        let accent: Color = .init("text_accent_color")
    }
    
    static let text: TextColor = .init()
}
