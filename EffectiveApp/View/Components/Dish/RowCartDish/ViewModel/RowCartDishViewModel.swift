//
//  RowCartDishViewModel.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Foundation


@MainActor
final class RowCartDishViewModel: DishViewModel {
    @Published private (set) var count: Int
    
    override init(dish: DishModel) {
        self.count = 1
        super.init(dish: dish)
    }
    
    
    func add() {
        self.count += 1
    }
    
    
    func remove() {
        self.count -= 1
    }
}
