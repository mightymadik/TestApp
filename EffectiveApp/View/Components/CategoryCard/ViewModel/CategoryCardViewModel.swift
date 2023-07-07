//
//  CategoryCardViewModel.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Foundation


@MainActor
final class CategoryCardViewModel: ViewModel {
    let category: CategoryModel
    
    
    init(category: CategoryModel) {
        self.category = category
    }
}
