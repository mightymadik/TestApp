//
//  HomeViewModel.swift
//  EffectiveApp
//
//  Created by MacBook on 07.07.2023.
//

import Foundation


@MainActor
final class HomeViewModel: ViewModel {
    @Published private (set) var categories: [CategoryModel] = []
    @Published var showAlert: Bool = false
    @Published private (set) var isLoading: Bool = false
    var error: Error? = nil
    private let apiManager: ApiManager = .init()
    
    private var categoriesCardVM: [CategoryCardViewModel] = []
    private var categoriesVM: [CategoryViewModel] = []
    
    
    func getCategoryVM(category: CategoryModel) -> CategoryViewModel {
        if let vm = self.categoriesVM.first(where: { $0.category == category }) {
            return vm
        } else {
            let (_, vm) = self.createVM(category: category)
            return vm
        }
    }
    
    
    func getCategoryCardVM(category: CategoryModel) -> CategoryCardViewModel {
        if let vm = self.categoriesCardVM.first(where: { $0.category == category }) {
            return vm
        } else {
            let (vm, _) = self.createVM(category: category)
            return vm
        }
    }
    
    
    private func createVM(category: CategoryModel) -> (CategoryCardViewModel, CategoryViewModel) {
        let cardVM = CategoryCardViewModel(category: category)
        let viewVM = CategoryViewModel(category: category)
        
        self.categoriesVM.append(viewVM)
        self.categoriesCardVM.append(cardVM)
        
        return (cardVM, viewVM)
    }
    
    
    func fetchCategories() async {
        self.isLoading = true
        do {
            self.categories = try await self.apiManager.fetchCategories()
        } catch let error {
            self.error = error
            self.showAlert = true
        }
        self.isLoading = false
    }
}
