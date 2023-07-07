//
//  CartViewModel.swift
//  EffectiveApp
//
//  Created by MacBook on 07.07.2023.
//

import Combine
import Foundation


@MainActor
final class CartViewModel: ViewModel {
    @Published private (set) var dishes: [DishModel] = []
    @Published private (set) var total: Double = 0
    
    private (set) var dishVMs: [RowCartDishViewModel] = []
    let buttonVM: AccentButtonViewModel = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    
    func getVM(dish: DishModel) -> RowCartDishViewModel {
        if let vm = self.dishVMs.first(where: { $0.dish == dish }) {
            return vm
        } else {
            let vm = RowCartDishViewModel(dish: dish)
            self.dishVMs.append(vm)
            return vm
        }
    }
    
    
    func addDish(dish: DishModel) {
        let dishVM = RowCartDishViewModel(dish: dish)
        self.dishVMs.append(dishVM)
        self.dishes.append(dish)
        
        dishVM.$count
            .sink { count in
                if count == 0 {
                    self.removeDish(id: dish.id)
                    self.total -= dish.price
                } else {
                    self.total += (count >= dishVM.count ? dish.price : -dish.price)
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func removeDish(id: Int) {
        guard let idx: Int = self.dishes.firstIndex(where: { $0.id == id }) else {
            return
        }
        self.dishes.remove(at: idx)
        
        guard let vmIdx: Int = self.dishVMs.firstIndex(where: { $0.dish.id == id }) else {
            return
        }
        self.dishVMs.remove(at: vmIdx)
    }
}
