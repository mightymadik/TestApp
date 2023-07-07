//
//  Coordinator.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Foundation


@MainActor
final class Coordinator: ObservableObject {
    @Published private (set) var state: MainViewState = .home
    static let shared: Coordinator = .init()
    
    private init() {
        
    }
    
    
    func setViewState(_ state: MainViewState) {
        if state == .search || state == .profile {
            return
        }
        self.state = state
    }
}
