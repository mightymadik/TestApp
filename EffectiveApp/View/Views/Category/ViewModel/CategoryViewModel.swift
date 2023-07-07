//
//  CategoryViewModel.swift
//  EffectiveApp
//
//  Created by MacBook on 06.07.2023.
//

import Combine
import Foundation


@MainActor
final class CategoryViewModel: ViewModel {
    @Published private (set) var tags: [String] = []
    @Published private (set) var selectedTag: String = "Все меню"
    @Published private (set) var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published private (set) var sortedDishes: [DishModel] = []
    
    
    private (set) var dishes: [DishModel] = []
    var error: Error? = nil
    private (set) var category: CategoryModel
    
    
    private var cancellables: Set<AnyCancellable> = []
    private let apiManager: ApiManager = .init()
    
    
    init(category: CategoryModel) {
        self.category = category
        self.setTagSubscription()
    }
    
    
    private func setTagSubscription() {
        $selectedTag
            .sink { tag in
                self.sortedDishes = self.dishes.filter({ $0.tegs.contains(tag) })
            }
            .store(in: &cancellables)
    }
    
    
    func setTag(tag: String) {
        self.selectedTag = tag
    }
    
    
    func fetchDishes() async {
        self.isLoading = true
        
        do {
            self.dishes = try await self.apiManager.fetchDishes()
            self.tags = Array(Set(self.dishes.flatMap({ $0.tegs })))
            self.tags.sort { lhs, rhs in
                if lhs == "Все меню" {
                    return true
                } else {
                    return lhs < rhs
                }
            }
            self.sortedDishes = self.dishes
        } catch let error {
            self.error = error
            self.showAlert = true
        }
        
        self.isLoading = false
    }
}
