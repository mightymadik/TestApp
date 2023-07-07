//
//  MainViewState.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Foundation


enum MainViewState: Equatable {
    static func == (lhs: MainViewState, rhs: MainViewState) -> Bool {
        switch (lhs, rhs) {
                case (.home(let lhsActions), .home(let rhsActions)):
                    return lhsActions == rhsActions
                case (.search, .search),
                     (.cart, .cart),
                     (.profile, .profile):
                    return true
                default:
                    return false
                }
    }
    
    case home(actions: HomeViewState?)
    case search
    case cart
    case profile
    
    
    static let home: Self = .home(actions: .none)
    
    
    var label: String {
        switch self {
        case .home:
            return "Главная"
        case .search:
            return "Поиск"
        case .cart:
            return "Корзина"
        case .profile:
            return "Аккаунт"
        }
    }
    
    
    var icon: String {
        switch self {
        case .home:
            return "home_tab"
        case .search:
            return "search_tab"
        case .cart:
            return "cart_tab"
        case .profile:
            return "profile_tab"
        }
    }
}
