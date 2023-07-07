//
//  FontsApperance.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import SwiftUI


enum AppFontCase {
    case header1
    case subHeader1
    case header2
    case header3
    case text
    case large
    case tab
    
    
    var font: Font {
        switch self {
        case .header1: return .system(size: 18, weight: .medium, design: .default)
        case .subHeader1: return .system(size: 14, weight: .regular, design: .default)
        case .header2: return .system(size: 16, weight: .medium, design: .default)
        case .large: return .system(size: 20, weight: .medium, design: .default)
        case .tab: return .system(size: 10, weight: .medium, design: .default)
        case .header3: return .system(size: 16, weight: .medium, design: .default)
        case .text: return .system(size: 14, weight: .regular, design: .default)
        }
    }
}


extension View {
    
    @ViewBuilder
    func appFont(_ type: AppFontCase) -> some View {
        font(type.font)
    }
}
