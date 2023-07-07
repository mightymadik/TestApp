//
//  DishViewModel.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Foundation


@MainActor
class DishViewModel: ViewModel {
    private (set) var dish: DishModel
    
    init(dish: DishModel) {
        self.dish = dish
    }
}
